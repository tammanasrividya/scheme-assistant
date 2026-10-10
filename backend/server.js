const express = require('express');
const cors = require('cors');
const pool = require('./db');
const { evaluate } = require('./matcher');
const { cleanProfile } = require('./validate');
const path = require('path');
const app = express();
app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, '..', 'frontend', 'dist')));

// Check: server and database working?
app.get('/api/health', async (req, res) => {
  try {
    await pool.query('SELECT 1');
    res.json({ ok: true });
  } catch (err) {
    res.status(500).json({ ok: false, error: err.message });
  }
});

// Search: /api/schemes?q=pension&category=Pension
app.get('/api/schemes', async (req, res) => {
  try {
    const q = req.query.q || null;
    const category = req.query.category || null;
    const result = await pool.query(
      `SELECT scheme_id, name, category, target_group, benefits
       FROM schemes
       WHERE is_active = TRUE
         AND ($1::text IS NULL OR name ILIKE '%' || $1 || '%' OR target_group ILIKE '%' || $1 || '%')
         AND ($2::text IS NULL OR category ILIKE $2 || '%')
       ORDER BY scheme_id`,
      [q, category]
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Details: /api/schemes/AP002
app.get('/api/schemes/:id', async (req, res) => {
  try {
    const scheme = await pool.query('SELECT * FROM schemes WHERE scheme_id = $1', [req.params.id]);
    if (scheme.rows.length === 0) return res.status(404).json({ error: 'Scheme not found' });
    const sources = await pool.query(
      'SELECT source_url, source_type, last_checked_at FROM sources WHERE scheme_id = $1',
      [req.params.id]
    );
        const docs = await pool.query(
      'SELECT document_name, notes FROM required_documents WHERE scheme_id = $1 ORDER BY document_id',
      [req.params.id]
    );
    res.json({ ...scheme.rows[0], sources: sources.rows, documents: docs.rows });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
// Match: user profile -> list of schemes with status
async function handleMatch(req, res) {
  try {
        const { profile, errors } = cleanProfile({ ...req.query, ...(req.body || {}) });
    if (errors.length > 0) return res.status(400).json({ errors });
    const schemes = await pool.query(
      'SELECT scheme_id, name, category, benefits, application_url FROM schemes WHERE is_active = TRUE ORDER BY scheme_id'
    );
    const rules = await pool.query('SELECT * FROM eligibility_rules');
        const docs = await pool.query('SELECT scheme_id, document_name FROM required_documents ORDER BY document_id');
    const results = schemes.rows.map((s) => {
        const r = evaluate(rules.rows.filter((x) => x.scheme_id === s.scheme_id), profile);
      return {
        scheme_id: s.scheme_id,
        name: s.name,
        category: s.category,
        benefits: s.benefits,
        official_link: s.application_url,
        documents: docs.rows.filter((d) => d.scheme_id === s.scheme_id).map((d) => d.document_name),
        status: r.status,
        criteria_not_met: r.failed.map((f) => `${f.rule_type}: ${f.field_name} ${f.operator} ${f.expected_value}`),
        information_needed: r.missing,
      };
    });
    res.json({
      disclaimer: 'Preliminary result only. The government authority makes the final decision.',
      results,
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
}
app.get('/api/match', handleMatch);   // easy browser testing
app.post('/api/match', handleMatch);  // used by the React form later
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));