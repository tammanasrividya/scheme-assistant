import { useState, useEffect } from 'react';
import './App.css';

const YESNO = [['true', 'Yes'], ['false', 'No']];

const BASIC_FIELDS = [
  { name: 'age', label: 'Age', type: 'number' },
  { name: 'gender', label: 'Gender', options: [['female', 'Female'], ['male', 'Male'], ['transgender', 'Transgender']] },
  { name: 'ap_resident', label: 'Do you live in Andhra Pradesh?', options: YESNO },
  { name: 'occupation', label: 'Occupation / applicant type', options: [
    ['student', 'Student'], ['handloom_weaver', 'Handloom weaver'], ['powerloom_unit_holder', 'Powerloom unit holder'],
    ['toddy_tapper', 'Toddy tapper'], ['fisherman', 'Fisherman'], ['traditional_cobbler', 'Traditional cobbler'],
    ['dappu_artist', 'Dappu artist'], ['farmer', 'Farmer'], ['other', 'Other'],
  ] },
  { name: 'annual_family_income', label: 'Annual family income (Rs.)', type: 'number' },
];

const MORE_FIELDS = [
  { name: 'ration_card', label: 'Ration card type', options: [['white', 'White'], ['other', 'Other'], ['none', 'None']] },
  { name: 'marital_status', label: 'Marital status', options: [['widow', 'Widow'], ['married', 'Married'], ['unmarried', 'Unmarried'], ['separated', 'Separated or deserted']] },
  { name: 'destitute', label: 'Destitute (no means of support)?', options: YESNO },
  { name: 'has_other_pension', label: 'Already getting another pension?', options: YESNO },
  { name: 'govt_employee', label: 'Government/PSU employee or pensioner?', options: YESNO },
  { name: 'income_tax_payer', label: 'Income tax payer?', options: YESNO },
  { name: 'owns_car', label: 'Owns a car?', options: YESNO },
  { name: 'disability_percent', label: 'Disability percentage (if any)', type: 'number' },
  { name: 'course_level', label: 'Course level (students)', options: [['iti', 'ITI'], ['polytechnic', 'Polytechnic'], ['degree_and_above', 'Degree and above'], ['other', 'Other']] },
  { name: 'social_category', label: 'Social category (optional)', options: [['sc', 'SC'], ['st', 'ST'], ['bc', 'BC'], ['ebc', 'EBC'], ['minority', 'Minority'], ['differently_abled', 'Differently abled'], ['other', 'Other']] },
  { name: 'has_weaver_certificate', label: 'Have Weaver Certificate / Pehchan Card?', options: YESNO },
  { name: 'has_powerloom_registration', label: 'Have Powerloom Registration Certificate?', options: YESNO },
  { name: 'has_discom_dues', label: 'Pending electricity (DISCOM) dues?', options: YESNO },
  { name: 'is_coop_member', label: 'Member of a Primary Handloom Weavers Co-operative Society?', options: YESNO },
];

const ALL_FIELDS = [...BASIC_FIELDS, ...MORE_FIELDS];
const LABELS = Object.fromEntries(ALL_FIELDS.map((f) => [f.name, f.label]));
const EMPTY = Object.fromEntries(ALL_FIELDS.map((f) => [f.name, '']));

const GROUPS = [
  ['potential_match', 'Potential matches', 'green'],
  ['more_information_needed', 'More information needed', 'yellow'],
  ['criteria_not_matched', 'Criteria not matched', 'red'],
  ['rules_not_added', 'Eligibility rules not added yet', 'grey'],
];

const CATEGORIES = ['Pension', 'Handlooms', 'Education', 'Transport'];

function short(text, n = 170) {
  if (!text) return '';
  return text.length > n ? text.slice(0, n) + '...' : text;
}

export default function App() {
  const [tab, setTab] = useState('search');

  // Search tab
  const [q, setQ] = useState('');
  const [category, setCategory] = useState('');
  const [schemes, setSchemes] = useState([]);
  const [selected, setSelected] = useState(null);

  // Check tab
  const [profile, setProfile] = useState(EMPTY);
  const [showMore, setShowMore] = useState(false);
  const [results, setResults] = useState(null);

  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  async function runSearch(e) {
    if (e) e.preventDefault();
    setError('');
    try {
      const params = new URLSearchParams();
      if (q) params.set('q', q);
      if (category) params.set('category', category);
      const res = await fetch('/api/schemes?' + params.toString());
      if (!res.ok) throw new Error();
      setSchemes(await res.json());
    } catch {
      setError('Could not reach the server. Is the backend running?');
    }
  }

  useEffect(() => { runSearch(); }, []);

  async function openScheme(id) {
    try {
      const res = await fetch('/api/schemes/' + id);
      if (!res.ok) throw new Error();
      setSelected(await res.json());
    } catch {
      setError('Could not load scheme details.');
    }
  }

  async function checkEligibility(e) {
    e.preventDefault();
    setLoading(true);
    setError('');
    const body = Object.fromEntries(Object.entries(profile).filter(([, v]) => v !== ''));
    try {
      const res = await fetch('/api/match', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(body),
      });
      if (!res.ok) throw new Error();
      const data = await res.json();
      setResults(data.results);
    } catch {
      setError('Could not reach the server. Is the backend running?');
    }
    setLoading(false);
  }

  function renderField(f) {
    return (
      <label key={f.name}>
        <span>{f.label}</span>
        {f.options ? (
          <select value={profile[f.name]} onChange={(e) => setProfile({ ...profile, [f.name]: e.target.value })}>
            <option value="">Prefer not to say / skip</option>
            {f.options.map(([v, t]) => <option key={v} value={v}>{t}</option>)}
          </select>
        ) : (
          <input type="number" min="0" value={profile[f.name]}
            onChange={(e) => setProfile({ ...profile, [f.name]: e.target.value })} />
        )}
      </label>
    );
  }

  return (
    <div className="container">
      <header className="hero">
        <div className="hero-badge">Andhra Pradesh</div>
        <h1>Smart Government Scheme Assistant</h1>
        <p>Find schemes you may be eligible for, with links to official sources.</p>
      </header>

      <div className="tabs">
        <button className={tab === 'search' ? 'active' : ''} onClick={() => setTab('search')}>Search schemes</button>
        <button className={tab === 'check' ? 'active' : ''} onClick={() => setTab('check')}>Check my eligibility</button>
      </div>

      {error && <div className="error">{error}</div>}

      {tab === 'search' && (
        <>
          <form className="panel row" onSubmit={runSearch}>
            <input placeholder="Search e.g. pension, weaver, bus" value={q} onChange={(e) => setQ(e.target.value)} />
            <select value={category} onChange={(e) => setCategory(e.target.value)}>
              <option value="">All categories</option>
              {CATEGORIES.map((c) => <option key={c} value={c}>{c}</option>)}
            </select>
            <button className="primary" type="submit">Search</button>
          </form>

          {selected && (
            <div className="panel">
              <button className="link" onClick={() => setSelected(null)}>&larr; Back to list</button>
              <h2>{selected.name}</h2>
              <div className="cat">{selected.category}</div>
              <p><b>Who it is for:</b> {selected.target_group}</p>
              <p><b>Known criteria:</b> {selected.known_criteria}</p>
              <p><b>Benefits:</b> {selected.benefits}</p>
              <p className="small">Verified on {selected.verified_on ? String(selected.verified_on).slice(0, 10) : 'N/A'} | {selected.verification_status}</p>

              <b>Documents needed:</b>
              {selected.documents && selected.documents.length > 0 ? (
                <ul>
                  {selected.documents.map((d, i) => (
                    <li key={i}>{d.document_name}{d.notes ? ` (${d.notes})` : ''}</li>
                  ))}
                </ul>
              ) : (
                <p className="small">Document list not available yet. Please check the official source or your Village/Ward Secretariat.</p>
              )}

              <b>Official sources:</b>
              <ul>
                {selected.sources.map((s, i) => (
                  <li key={i}><a href={s.source_url} target="_blank" rel="noreferrer">{s.source_url}</a></li>
                ))}
              </ul>
            </div>
          )}

          {!selected && (
            <>
              <div className="small" style={{ marginBottom: 8 }}>{schemes.length} scheme(s) found</div>
              {schemes.map((s) => (
                <div className="card" key={s.scheme_id}>
                  <h3>{s.name}</h3>
                  <div className="cat">{s.category}</div>
                  <div className="small">{short(s.benefits)}</div>
                  <button className="link" onClick={() => openScheme(s.scheme_id)}>View details</button>
                </div>
              ))}
            </>
          )}
        </>
      )}

      {tab === 'check' && (
        <>
          <form className="panel" onSubmit={checkEligibility}>
            <div className="small">Fill only what you know. We use these details only to compare with scheme rules. Do not enter Aadhaar or bank details.</div>
            <div className="grid">{BASIC_FIELDS.map(renderField)}</div>
            <button type="button" className="link" onClick={() => setShowMore(!showMore)}>
              {showMore ? 'Hide' : 'Show'} more details (improves accuracy)
            </button>
            {showMore && <div className="grid">{MORE_FIELDS.map(renderField)}</div>}
            <div style={{ marginTop: 12 }}>
              <button className="primary" type="submit" disabled={loading}>{loading ? 'Checking...' : 'Check eligibility'}</button>
            </div>
          </form>

          {results && (
            <>
              <div className="disclaimer">These results are preliminary and do not guarantee any benefit. The government authority makes the final decision. Please confirm on the official link.</div>
              {GROUPS.map(([status, title, color]) => {
                const items = results.filter((r) => r.status === status);
                if (items.length === 0) return null;
                return (
                  <div key={status}>
                    <h2>{title} ({items.length})</h2>
                    {items.map((r) => (
                      <div className={'card ' + color} key={r.scheme_id}>
                        <h3>{r.name}</h3>
                        <div className="cat">{r.category}</div>
                        <div className="small">{short(r.benefits)}</div>
                        {r.information_needed.length > 0 && (
                          <p className="small"><b>Tell us:</b> {r.information_needed.map((f) => LABELS[f] || f).join(', ')}</p>
                        )}
                        {r.criteria_not_met.length > 0 && (
                          <p className="small"><b>Not matched:</b> {r.criteria_not_met.join('; ')}</p>
                        )}
                        {(status === 'potential_match' || status === 'more_information_needed') && (
                          <p className="small"><b>Documents:</b> {r.documents && r.documents.length > 0 ? r.documents.join('; ') : 'List not available yet, check the official source.'}</p>
                        )}
                        {status === 'rules_not_added' && (
                          <p className="small">Eligibility rules for this scheme are not added yet. Please check the official source.</p>
                        )}
                        <a href={r.official_link} target="_blank" rel="noreferrer">Official source</a>
                      </div>
                    ))}
                  </div>
                );
              })}
            </>
          )}
        </>
      )}
    </div>
  );
}