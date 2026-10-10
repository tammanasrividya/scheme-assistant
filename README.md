# Smart Government Scheme Assistant

Web app that helps people find Andhra Pradesh government schemes they may be eligible for. Results are preliminary; the government authority makes the final decision.

## Stack
React (Vite) + Node.js/Express + PostgreSQL

## Run locally
1. Install Node.js and PostgreSQL. Create database `schemes_db`.
2. Restore data: psql -U postgres -d schemes_db -f data/schemes_db_backup.sql
3. In backend/, create `.env`:
   DB_HOST=localhost
   DB_PORT=5432
   DB_USER=postgres
   DB_PASSWORD=your_password
   DB_NAME=schemes_db
4. Backend: cd backend, npm install, node server.js
5. Frontend (development): cd frontend, npm install, npm run dev
6. Production-style: cd frontend, npm run build, then open http://localhost:5000

## Data
Starter dataset: data/ap_schemes_100pct_verified.csv (17 active schemes from official sources).
See DATA_UPDATE.md for how the team adds or edits schemes.

## Privacy
No Aadhaar numbers, bank details or identity uploads are collected.