const fs = require('fs');
const { parse } = require('csv-parse/sync');
const pool = require('../db');

async function main() {
  const file = process.argv[2];
  if (!file) {
    console.log('Usage: node scripts/import-csv.js <path-to-csv>');
    process.exit(1);
  }

  const rows = parse(fs.readFileSync(file, 'utf8'), {
    columns: true,
    skip_empty_lines: true,
    bom: true,
  });

  for (const r of rows) {
    // Insert new scheme, or update it if scheme_id already exists
    await pool.query(
      `INSERT INTO schemes
         (scheme_id, name, category, target_group, known_criteria, benefits,
          effective_from, application_url, notes, verified_on, verification_status)
       VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11)
       ON CONFLICT (scheme_id) DO UPDATE SET
         name = EXCLUDED.name,
         category = EXCLUDED.category,
         target_group = EXCLUDED.target_group,
         known_criteria = EXCLUDED.known_criteria,
         benefits = EXCLUDED.benefits,
         effective_from = EXCLUDED.effective_from,
         application_url = EXCLUDED.application_url,
         notes = EXCLUDED.notes,
         verified_on = EXCLUDED.verified_on,
         verification_status = EXCLUDED.verification_status`,
      [
        r.scheme_id, r.scheme_name, r.category, r.target_group, r.known_criteria,
        r.benefit_summary, r.effective_from, r.official_source, r.notes,
        r.verified_on || null, r.verification_status,
      ]
    );

    // Refresh the source links for this scheme
    await pool.query('DELETE FROM sources WHERE scheme_id = $1', [r.scheme_id]);
    const links = [];
    if (r.official_source) links.push([r.official_source, 'primary']);
    (r.supporting_official_sources || '')
      .split('|')
      .map((u) => u.trim())
      .filter(Boolean)
      .forEach((u) => links.push([u, 'supporting']));
    for (const [url, type] of links) {
      await pool.query(
        'INSERT INTO sources (scheme_id, source_url, source_type, last_checked_at) VALUES ($1,$2,$3,$4)',
        [r.scheme_id, url, type, r.verified_on || null]
      );
    }
  }

  console.log(`Imported ${rows.length} scheme(s) from ${file}`);
  await pool.end();
}

main().catch((err) => {
  console.error('Import failed:', err.message);
  process.exit(1);
});