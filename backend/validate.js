const ALLOWED = [
  'age', 'gender', 'ap_resident', 'occupation', 'annual_family_income', 'ration_card',
  'marital_status', 'destitute', 'has_other_pension', 'govt_employee', 'income_tax_payer',
  'owns_car', 'disability_percent', 'course_level', 'social_category',
  'has_weaver_certificate', 'has_powerloom_registration', 'has_discom_dues', 'is_coop_member',
];

const NUMERIC = {
  age: [0, 120],
  annual_family_income: [0, 1000000000],
  disability_percent: [0, 100],
};

function cleanProfile(input) {
  const profile = {};
  const errors = [];
  for (const key of ALLOWED) {
    let v = input[key];
    if (v === undefined || v === null || v === '') continue;
    v = String(v).trim().toLowerCase().slice(0, 50);
    if (key in NUMERIC) {
      const n = Number(v);
      const [min, max] = NUMERIC[key];
      if (!Number.isFinite(n) || n < min || n > max) {
        errors.push(`${key} must be a number between ${min} and ${max}`);
        continue;
      }
      profile[key] = n;
    } else {
      if (!/^[a-z_]+$/.test(v)) {
        errors.push(`${key} has an invalid value`);
        continue;
      }
      profile[key] = v;
    }
  }
  return { profile, errors };
}

module.exports = { cleanProfile };