function checkRule(rule, profile) {
  const v = profile[rule.field_name];
  if (v === undefined || v === null || v === '') return 'unknown';
  const exp = rule.expected_value;
  switch (rule.operator) {
    case '=':  return String(v).toLowerCase() === exp.toLowerCase() ? 'pass' : 'fail';
    case '>=': return Number(v) >= Number(exp) ? 'pass' : 'fail';
    case '<=': return Number(v) <= Number(exp) ? 'pass' : 'fail';
    case '>':  return Number(v) > Number(exp) ? 'pass' : 'fail';
    case '<':  return Number(v) < Number(exp) ? 'pass' : 'fail';
    case 'in': return exp.split(',').includes(String(v).toLowerCase()) ? 'pass' : 'fail';
    default:   return 'unknown';
  }
}

function evaluate(rules, profile) {
  if (rules.length === 0) return { status: 'rules_not_added', failed: [], missing: [] };
  const failed = [];
  const missing = [];
  for (const r of rules) {
    const res = checkRule(r, profile);
    if (res === 'unknown') { missing.push(r.field_name); continue; }
    // eligibility rule must pass; exclusion rule must NOT pass
    if (r.rule_type === 'eligibility' && res === 'fail') failed.push(r);
    if (r.rule_type === 'exclusion' && res === 'pass') failed.push(r);
  }
  if (failed.length > 0) return { status: 'criteria_not_matched', failed, missing: [] };
  if (missing.length > 0) return { status: 'more_information_needed', failed: [], missing: [...new Set(missing)] };
  return { status: 'potential_match', failed: [], missing: [] };
}

module.exports = { evaluate };