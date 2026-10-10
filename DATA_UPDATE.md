# How to update scheme data

Rule: only use official government pages and orders. If sources conflict, do not guess. Leave the field out and mark it for review.

## Add or edit schemes (CSV)
1. Open data/ap_schemes_100pct_verified.csv in Excel/Sheets.
2. Add a new row (new scheme_id) or edit an existing row. Set verified_on to today's date (YYYY-MM-DD).
3. A teammate cross-checks the row against the official page.
4. Run, from the backend folder:
   node scripts/import-csv.js ..\data\ap_schemes_100pct_verified.csv

## Deactivate a scheme (hide it from the app)
UPDATE schemes SET is_active = FALSE WHERE scheme_id = 'AP0XX';

## Re-activate
UPDATE schemes SET is_active = TRUE WHERE scheme_id = 'AP0XX';

## Add eligibility rules
INSERT INTO eligibility_rules (scheme_id, rule_type, field_name, operator, expected_value)
VALUES ('AP0XX', 'eligibility', 'age', '>=', '60');
- rule_type: eligibility or exclusion
- operator: =, >=, <=, >, <, in
- Each rule must come from the official source in the CSV row.

## Add required documents
INSERT INTO required_documents (scheme_id, document_name, notes)
VALUES ('AP0XX', 'Valid ID proof', NULL);

## Before every release
Re-check amounts and rules against the official pages and orders, update verified_on, and take a backup:
pg_dump -U postgres -d schemes_db -f data\schemes_db_backup.sql