--
-- PostgreSQL database dump
--

\restrict Jvjus86awmwqzWcMg2aaw5eSxWNrEXnPUCGkPBkGn9kXJimIH4QyHgjOIPj3WsN

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: eligibility_rules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eligibility_rules (
    rule_id integer NOT NULL,
    scheme_id text,
    rule_type text,
    field_name text,
    operator text,
    expected_value text,
    notes text
);


ALTER TABLE public.eligibility_rules OWNER TO postgres;

--
-- Name: eligibility_rules_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eligibility_rules_rule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.eligibility_rules_rule_id_seq OWNER TO postgres;

--
-- Name: eligibility_rules_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eligibility_rules_rule_id_seq OWNED BY public.eligibility_rules.rule_id;


--
-- Name: required_documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_documents (
    document_id integer NOT NULL,
    scheme_id text,
    document_name text,
    notes text
);


ALTER TABLE public.required_documents OWNER TO postgres;

--
-- Name: required_documents_document_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.required_documents_document_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.required_documents_document_id_seq OWNER TO postgres;

--
-- Name: required_documents_document_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.required_documents_document_id_seq OWNED BY public.required_documents.document_id;


--
-- Name: schemes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schemes (
    scheme_id text NOT NULL,
    name text NOT NULL,
    category text,
    target_group text,
    known_criteria text,
    benefits text,
    effective_from text,
    application_url text,
    notes text,
    verified_on date,
    verification_status text,
    is_active boolean DEFAULT true
);


ALTER TABLE public.schemes OWNER TO postgres;

--
-- Name: schemes_raw; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schemes_raw (
    scheme_id text,
    scheme_name text,
    category text,
    target_group text,
    known_criteria text,
    benefit_summary text,
    effective_from text,
    official_source text,
    supporting_official_sources text,
    notes text,
    verified_on text,
    verification_status text
);


ALTER TABLE public.schemes_raw OWNER TO postgres;

--
-- Name: sources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sources (
    source_id integer NOT NULL,
    scheme_id text,
    source_url text,
    source_type text,
    last_checked_at date
);


ALTER TABLE public.sources OWNER TO postgres;

--
-- Name: sources_source_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sources_source_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sources_source_id_seq OWNER TO postgres;

--
-- Name: sources_source_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sources_source_id_seq OWNED BY public.sources.source_id;


--
-- Name: eligibility_rules rule_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eligibility_rules ALTER COLUMN rule_id SET DEFAULT nextval('public.eligibility_rules_rule_id_seq'::regclass);


--
-- Name: required_documents document_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_documents ALTER COLUMN document_id SET DEFAULT nextval('public.required_documents_document_id_seq'::regclass);


--
-- Name: sources source_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sources ALTER COLUMN source_id SET DEFAULT nextval('public.sources_source_id_seq'::regclass);


--
-- Data for Name: eligibility_rules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eligibility_rules (rule_id, scheme_id, rule_type, field_name, operator, expected_value, notes) FROM stdin;
1	AP002	eligibility	ration_card	=	white	\N
2	AP003	eligibility	ration_card	=	white	\N
3	AP004	eligibility	ration_card	=	white	\N
4	AP005	eligibility	ration_card	=	white	\N
5	AP006	eligibility	ration_card	=	white	\N
6	AP007	eligibility	ration_card	=	white	\N
7	AP008	eligibility	ration_card	=	white	\N
8	AP009	eligibility	ration_card	=	white	\N
9	AP013	eligibility	ration_card	=	white	\N
10	AP002	exclusion	has_other_pension	=	true	\N
11	AP003	exclusion	has_other_pension	=	true	\N
12	AP004	exclusion	has_other_pension	=	true	\N
13	AP005	exclusion	has_other_pension	=	true	\N
14	AP006	exclusion	has_other_pension	=	true	\N
15	AP007	exclusion	has_other_pension	=	true	\N
16	AP008	exclusion	has_other_pension	=	true	\N
17	AP009	exclusion	has_other_pension	=	true	\N
18	AP013	exclusion	has_other_pension	=	true	\N
19	AP002	eligibility	age	>=	60	\N
20	AP002	eligibility	destitute	=	true	\N
21	AP002	exclusion	govt_employee	=	true	\N
22	AP002	exclusion	income_tax_payer	=	true	\N
23	AP002	exclusion	owns_car	=	true	\N
24	AP003	eligibility	marital_status	=	widow	\N
25	AP003	eligibility	age	>=	18	\N
26	AP004	eligibility	disability_percent	>=	40	\N
27	AP005	eligibility	occupation	=	handloom_weaver	\N
28	AP005	eligibility	age	>=	50	\N
29	AP006	eligibility	occupation	=	toddy_tapper	\N
30	AP006	eligibility	age	>=	50	\N
31	AP007	eligibility	occupation	=	fisherman	\N
32	AP007	eligibility	age	>=	50	\N
33	AP008	eligibility	occupation	=	traditional_cobbler	\N
34	AP008	eligibility	age	>	40	\N
35	AP009	eligibility	gender	=	transgender	\N
36	AP009	eligibility	age	>=	18	\N
37	AP013	eligibility	occupation	=	dappu_artist	\N
38	AP013	eligibility	age	>	50	\N
39	AP014	eligibility	occupation	=	handloom_weaver	\N
40	AP014	eligibility	ap_resident	=	true	\N
41	AP014	eligibility	has_weaver_certificate	=	true	\N
42	AP014	exclusion	has_discom_dues	=	true	\N
43	AP015	eligibility	occupation	=	powerloom_unit_holder	\N
44	AP015	eligibility	ap_resident	=	true	\N
45	AP015	eligibility	has_powerloom_registration	=	true	\N
46	AP015	exclusion	has_discom_dues	=	true	\N
47	AP001	eligibility	course_level	in	iti,polytechnic,degree_and_above	\N
48	AP001	eligibility	social_category	in	sc,st,bc,ebc,minority,differently_abled	\N
49	AP001	eligibility	annual_family_income	<=	250000	\N
50	AP020	eligibility	gender	in	female,transgender	\N
51	AP020	eligibility	ap_resident	=	true	\N
\.


--
-- Data for Name: required_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_documents (document_id, scheme_id, document_name, notes) FROM stdin;
\.


--
-- Data for Name: schemes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schemes (scheme_id, name, category, target_group, known_criteria, benefits, effective_from, application_url, notes, verified_on, verification_status, is_active) FROM stdin;
AP001	Post-Matric Scholarships (RTF/MTF)	Education	Eligible SC, ST, BC, EBC, minority and differently-abled students	Students in ITI, Polytechnic, Degree and above courses, in SC/ST/BC/EBC/Minority/Differently-abled categories, sanctioned in saturation mode. MTF: total family annual income Rs.2.50 lakh or less, and family land below 10 acres wet, or 25 acres dry, or 25 acres wet and dry combined.	RTF: full fee reimbursement (tuition fee, special fees, other fees and exam fees) as fixed by competent authorities, defined in G.O.Ms.No.115 SW(Edn) dt 30.11.2019 and G.O.Ms.No.04 SW(Edn) dt 18.06.2024. MTF for food and hostel expenses: Rs.10,000 per year (ITI), Rs.15,000 (Polytechnic), Rs.20,000 (Degree and above). RTF payment mode (G.O.Ms.No.87 SW(Edu.I) dt 20.11.2024): for non-SC students RTF is released to college accounts; for SC students RTF continues to be released to student accounts (GoI bears 60%).	RTF to college accounts for non-SC students from AY 2024-25, subject to FRS attendance in colleges from AY 2025-26 (G.O.Ms.No.87 dt 20.11.2024)	https://tirupati.ap.gov.in/social-welfare/	RTF income limit and current application dates are not included because they were not confirmed on an official page.	2026-10-09	Verified on official government source(s) listed	t
AP002	NTR Bharosa Pension – Old Age Pension	Pension / Social welfare	Eligible destitute older residents	Age 60 or above and destitute (little or no means of subsistence and no family or relative to depend upon). Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.4,000 per month (raised from Rs.3,000 by G.O.Ms.No.43 PR&RD dt 13.06.2024).	Payable from 01.04.2024; disbursed from 01.07.2024 with 3 months arrears (Rs.7,000 in July 2024); Rs.4,000 monthly thereafter	https://sspensions.ap.gov.in/SSP/Home/About	The About page still shows superseded rates (Rs.2,250 / Rs.3,000); use the G.O. for amounts. Exclusions (About page): govt/PSU employees and pensioners; income tax payers; land above 2.5 acres wet or 5 acres dry (except ST in ITDA scheduled areas); outsourced and private monthly-salaried employees; car owners; freedom fighter pension holders. Sanction: MPDO (rural) or Municipal Commissioner (urban).	2026-10-09	Verified on official government source(s) listed	t
AP003	NTR Bharosa Pension – Widow Pension	Pension / Social welfare	Eligible widows	Age 18 and above as per the Marriage Act. Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.4,000 per month (raised from Rs.3,000 by G.O.Ms.No.43 dt 13.06.2024).	Payable from 01.04.2024; disbursed from 01.07.2024 with 3 months arrears	https://sspensions.ap.gov.in/SSP/Home/About	About page shows superseded rates; use the G.O. for amounts. Same exclusion factors and sanctioning authority as AP002.	2026-10-09	Verified on official government source(s) listed	t
AP004	NTR Bharosa Pension – Disability Pension	Pension / Disability	Eligible persons with disabilities	Minimum 40% disability; no age limit. Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.6,000 per month for disabled persons and multi-deformity leprosy persons (raised from Rs.3,000 by G.O.Ms.No.43 PR&RD dt 13.06.2024).	Disbursed from 01.07.2024	https://sspensions.ap.gov.in/SSP/Home/About	The pension amount for fully disabled categories is deliberately omitted: official sources conflict (Rs.15,000 in the G.O. text versus Rs.10,000 on portal and district pages). Do not collect disability details unless needed and with a clear privacy notice. Same exclusions as AP002.	2026-10-09	Verified on official government source(s) listed	t
AP005	NTR Bharosa Pension – Weaver Pension	Pension / Handloom	Eligible handloom weavers	Weaver aged 50 years or above and destitute (SSP About page). Handlooms department: weavers above 50 years. Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.4,000 per weaver per month (Handlooms department: enhanced w.e.f. April 2024; G.O.Ms.No.43 dt 13.06.2024).	Payable from 01.04.2024; disbursed from 01.07.2024 with arrears	https://handlooms.ap.gov.in/stateschemes.html	Use handloom occupation and pension-specific conditions. About page shows superseded rates. Same exclusions as AP002.	2026-10-09	Verified on official government source(s) listed	t
AP006	NTR Bharosa Pension – Toddy Tapper Pension	Pension / Occupational	Eligible toddy tappers	Age 50 and above; member of a Toddy Co-operative Society (TCS) or an individual tapper under the Tree For Tappers (TFT) scheme who had completed 50 years of age as on 1.2.2009. Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.4,000 per month (raised from Rs.3,000 by G.O.Ms.No.43 dt 13.06.2024).	Payable from 01.04.2024; disbursed from 01.07.2024 with arrears	https://sspensions.ap.gov.in/SSP/Home/About	About page shows superseded rates. Same exclusions as AP002.	2026-10-09	Verified on official government source(s) listed	t
AP007	NTR Bharosa Pension – Fishermen Pension	Pension / Fisheries	Eligible fishermen	Fisherman aged 50 years or above. Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.4,000 per month (raised from Rs.3,000 by G.O.Ms.No.43 dt 13.06.2024).	Payable from 01.04.2024; disbursed from 01.07.2024 with arrears	https://sspensions.ap.gov.in/SSP/Home/About	About page shows superseded rates. Same exclusions as AP002.	2026-10-09	Verified on official government source(s) listed	t
AP008	NTR Bharosa Pension – Traditional Cobbler Pension	Pension / Occupational	Eligible traditional cobblers	Traditional cobbler above 40 years of age. Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.4,000 per month (raised from Rs.3,000 by G.O.Ms.No.43 dt 13.06.2024).	Payable from 01.04.2024; disbursed from 01.07.2024 with arrears	https://sspensions.ap.gov.in/SSP/Home/About	About page shows superseded rates. Same exclusions as AP002.	2026-10-09	Verified on official government source(s) listed	t
AP009	NTR Bharosa Pension – Transgender Pension	Pension / Social welfare	Eligible transgender residents	Transgender person aged 18 years or above. Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.4,000 per month (raised from Rs.3,000 by G.O.Ms.No.43 dt 13.06.2024).	Payable from 01.04.2024; disbursed from 01.07.2024 with arrears	https://sspensions.ap.gov.in/SSP/Home/About	Sensitive personal information must be optional and handled respectfully. About page shows superseded rates. Same exclusions as AP002.	2026-10-09	Verified on official government source(s) listed	t
AP010	NTR Bharosa Pension – Single Women Pension	Pension / Women	Eligible single women	Married women who are separated or deserted: above 35 years of age and separation period more than 1 year as on date of sanction. Unmarried women: 30 years and above in rural areas or 35 years and above in urban areas, with no support of the family. Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.4,000 per month (raised from Rs.3,000 by G.O.Ms.No.43 dt 13.06.2024).	Payable from 01.04.2024; disbursed from 01.07.2024 with arrears	https://sspensions.ap.gov.in/SSP/Home/About	Do not use one age threshold for every applicant. About page shows superseded rates. Same exclusions as AP002.	2026-10-09	Verified on official government source(s) listed	t
AP011	NTR Bharosa Pension – ART/PLHIV Pension	Pension / Health-related	Eligible persons receiving ART treatment	No age limit; 6 months of continuous treatment on ART (Anti Retroviral Therapy). Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.4,000 per month (raised from Rs.3,000 by G.O.Ms.No.43 dt 13.06.2024).	Payable from 01.04.2024; disbursed from 01.07.2024 with arrears	https://sspensions.ap.gov.in/SSP/Home/About	Health information is sensitive; avoid collecting it unless strictly necessary. About page shows superseded rates. Same exclusions as AP002.	2026-10-09	Verified on official government source(s) listed	t
AP012	NTR Bharosa Pension – CKDU Pension	Pension / Health-related	Eligible persons with specified chronic kidney disease conditions	No age limit. SSP About page: patients undergoing continuous kidney dialysis (CKDU - Chronic Kidney Disease of Unknown etiology). G.O.Ms.No.43 also covers non-dialysis CKDU: CKD with serum creatinine above 5 mg; CKD with estimated GFR below 15 ml; CKD with small contracted kidney. Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.10,000 per month for CKDU on dialysis (government or private hospital) and for the non-dialysis CKDU categories above (non-dialysis raised from Rs.5,000). G.O.Ms.No.43 dt 13.06.2024.	Non-dialysis enhancement disbursed from 01.07.2024; dialysis categories no change	https://sspensions.ap.gov.in/SSP/Home/About	Do not ask users to enter detailed medical records in the initial prototype. The same G.O. also lists Rs.10,000 for bilateral elephantiasis grade 4; kidney/liver/heart transplant; sickle cell disease; thalassemia; severe haemophilia - these are not in this CSV. Same exclusions as AP002.	2026-10-09	Verified on official government source(s) listed	t
AP013	NTR Bharosa Pension – Dappu Artist Pension	Pension / Arts	Eligible Dappu artists	Dappu artist above 50 years of age. Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.4,000 per month (raised from Rs.3,000 by G.O.Ms.No.43 dt 13.06.2024). The G.O. also lists a separate Rs.4,000 pension to artists.	Payable from 01.04.2024; disbursed from 01.07.2024 with arrears	https://sspensions.ap.gov.in/SSP/Home/About	About page shows Rs.3,000 which is superseded. Same exclusions as AP002.	2026-10-09	Verified on official government source(s) listed	t
AP014	Free Power for Handloom Weaver Households	Handlooms / Utilities	Eligible handloom weaver households	Permanent resident of Andhra Pradesh; individual weaver engaged in handloom weaving; loom operational and used solely for weaving; valid Weaver Certificate from the Dept of Handlooms and Textiles or Weaver Pehchan Card issued by Govt of India; no pending dues or arrears with the DISCOM at enrolment. Documents: Aadhaar, weaver certificate or Weaver Pehchan Card, latest electricity bill, bank details, self-declaration that the connection is used exclusively for weaving; tenants need an indemnity bond from the registered consumer.	Free power up to 200 units per month; subsidy adjusted automatically in the monthly electricity bill; consumption above the limit is paid by the applicant.	Orders to implement from 01.04.2026 (G.O.Ms.No.44 Industries and Commerce (Prog-II) dt 26.03.2025)	https://handlooms.ap.gov.in/stateschemes.html	Apply at the nearest Assistant Engineer office of the concerned section; officials of the Electricity Dept and District Handlooms and Textiles Office verify jointly. Subsidy stops if the household is found not engaged in weaving.	2026-10-09	Verified on official government source(s) listed	t
AP015	Free Power for Powerloom Units	Handlooms / Utilities	Eligible powerloom units	Permanent resident of Andhra Pradesh; powerloom unit holder engaged in power-operated weaving; loom operational and used solely for weaving; valid Powerloom Registration Certificate (SSI registration or other certificate recognising the unit); no pending dues or arrears with the DISCOM at enrolment. Other documents as for AP014.	Free power up to 500 units per month; subsidy adjusted in the monthly electricity bill; consumption above the limit is paid by the unit.	Orders to implement from 01.04.2026 (G.O.Ms.No.44 Industries and Commerce (Prog-II) dt 26.03.2025)	https://handlooms.ap.gov.in/stateschemes.html	Same application route and compliance rules as AP014.	2026-10-09	Verified on official government source(s) listed	t
AP016	Co-operative Handloom Weavers Thrift Fund Scheme	Handlooms / Savings support	Weaver members of Primary Handloom Weavers Co-operative Societies	Aim: to inculcate thrift habit among weaver members of Primary Handloom Weavers Co-operative Societies.	Government matching share enhanced from 8% to 16% (G.O.Ms.No.35 Industries and Commerce (Prog.II) dt 11.02.2019).	Matching share w.e.f. 01.04.2019; scheme being implemented from financial year 2024-25	https://handlooms.ap.gov.in/stateschemes.html	Do not infer benefits beyond the matching share without the latest orders.	2026-10-09	Verified on official government source(s) listed	t
AP017	Cash Credit to Primary Handloom Weavers Co-operative Societies	Handlooms / Institutional finance	Primary Handloom Weavers Co-operative Societies (PHWCSs)	Society-level scheme; not an individual citizen benefit.	Working capital finance for production and marketing of cloth extended to PHWCSs through District Co-operative Central Banks.	Not stated on the page	https://handlooms.ap.gov.in/stateschemes.html	May be excluded from the citizen-facing individual eligibility checker.	2026-10-09	Verified on official government source(s) listed	t
AP020	Stree Shakti Free Bus Travel Scheme	Transport / Women and transgender citizens	Girls, women and transgender citizens domiciled in Andhra Pradesh	Free bus travel for all girls, women and transgender citizens domiciled in Andhra Pradesh, with valid ID proof. Applicable to Pallevelugu, Ultra Pallevelugu, City Ordinary, Metro Express and Express services. Not applicable to Non-stop, Interstate, Contract Carriage, Chartered services and Package Tours. Permitted in Enclave routes.	Free travel on the covered APSRTC services; APSRTC estimates about Rs.1,000 per month saving per family.	Launched 15 August 2025 (G.O.Ms.No.27 T,R&B (PTD.I) Dept dt 11.08.2025)	https://www.apsrtc.ap.gov.in/coverage.php	Do not promise every bus or service is covered.	2026-10-09	Verified on official government source(s) listed	t
\.


--
-- Data for Name: schemes_raw; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schemes_raw (scheme_id, scheme_name, category, target_group, known_criteria, benefit_summary, effective_from, official_source, supporting_official_sources, notes, verified_on, verification_status) FROM stdin;
AP001	Post-Matric Scholarships (RTF/MTF)	Education	Eligible SC, ST, BC, EBC, minority and differently-abled students	Students in ITI, Polytechnic, Degree and above courses, in SC/ST/BC/EBC/Minority/Differently-abled categories, sanctioned in saturation mode. MTF: total family annual income Rs.2.50 lakh or less, and family land below 10 acres wet, or 25 acres dry, or 25 acres wet and dry combined.	RTF: full fee reimbursement (tuition fee, special fees, other fees and exam fees) as fixed by competent authorities, defined in G.O.Ms.No.115 SW(Edn) dt 30.11.2019 and G.O.Ms.No.04 SW(Edn) dt 18.06.2024. MTF for food and hostel expenses: Rs.10,000 per year (ITI), Rs.15,000 (Polytechnic), Rs.20,000 (Degree and above). RTF payment mode (G.O.Ms.No.87 SW(Edu.I) dt 20.11.2024): for non-SC students RTF is released to college accounts; for SC students RTF continues to be released to student accounts (GoI bears 60%).	RTF to college accounts for non-SC students from AY 2024-25, subject to FRS attendance in colleges from AY 2025-26 (G.O.Ms.No.87 dt 20.11.2024)	https://tirupati.ap.gov.in/social-welfare/	https://jnanabhumi.ap.gov.in/GOs/2024SW_MS87.pdf | https://jnanabhumi.ap.gov.in/	RTF income limit and current application dates are not included because they were not confirmed on an official page.	2026-10-09	Verified on official government source(s) listed
AP002	NTR Bharosa Pension – Old Age Pension	Pension / Social welfare	Eligible destitute older residents	Age 60 or above and destitute (little or no means of subsistence and no family or relative to depend upon). Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.4,000 per month (raised from Rs.3,000 by G.O.Ms.No.43 PR&RD dt 13.06.2024).	Payable from 01.04.2024; disbursed from 01.07.2024 with 3 months arrears (Rs.7,000 in July 2024); Rs.4,000 monthly thereafter	https://sspensions.ap.gov.in/SSP/Home/About	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf | https://sspensions.ap.gov.in/SSP/Home/Index | https://eluru.ap.gov.in/?p=37682	The About page still shows superseded rates (Rs.2,250 / Rs.3,000); use the G.O. for amounts. Exclusions (About page): govt/PSU employees and pensioners; income tax payers; land above 2.5 acres wet or 5 acres dry (except ST in ITDA scheduled areas); outsourced and private monthly-salaried employees; car owners; freedom fighter pension holders. Sanction: MPDO (rural) or Municipal Commissioner (urban).	2026-10-09	Verified on official government source(s) listed
AP003	NTR Bharosa Pension – Widow Pension	Pension / Social welfare	Eligible widows	Age 18 and above as per the Marriage Act. Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.4,000 per month (raised from Rs.3,000 by G.O.Ms.No.43 dt 13.06.2024).	Payable from 01.04.2024; disbursed from 01.07.2024 with 3 months arrears	https://sspensions.ap.gov.in/SSP/Home/About	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	About page shows superseded rates; use the G.O. for amounts. Same exclusion factors and sanctioning authority as AP002.	2026-10-09	Verified on official government source(s) listed
AP004	NTR Bharosa Pension – Disability Pension	Pension / Disability	Eligible persons with disabilities	Minimum 40% disability; no age limit. Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.6,000 per month for disabled persons and multi-deformity leprosy persons (raised from Rs.3,000 by G.O.Ms.No.43 PR&RD dt 13.06.2024).	Disbursed from 01.07.2024	https://sspensions.ap.gov.in/SSP/Home/About	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf | https://sspensions.ap.gov.in/SSP/Home/Index | https://eluru.ap.gov.in/?p=37682	The pension amount for fully disabled categories is deliberately omitted: official sources conflict (Rs.15,000 in the G.O. text versus Rs.10,000 on portal and district pages). Do not collect disability details unless needed and with a clear privacy notice. Same exclusions as AP002.	2026-10-09	Verified on official government source(s) listed
AP005	NTR Bharosa Pension – Weaver Pension	Pension / Handloom	Eligible handloom weavers	Weaver aged 50 years or above and destitute (SSP About page). Handlooms department: weavers above 50 years. Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.4,000 per weaver per month (Handlooms department: enhanced w.e.f. April 2024; G.O.Ms.No.43 dt 13.06.2024).	Payable from 01.04.2024; disbursed from 01.07.2024 with arrears	https://handlooms.ap.gov.in/stateschemes.html	https://sspensions.ap.gov.in/SSP/Home/About | https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	Use handloom occupation and pension-specific conditions. About page shows superseded rates. Same exclusions as AP002.	2026-10-09	Verified on official government source(s) listed
AP006	NTR Bharosa Pension – Toddy Tapper Pension	Pension / Occupational	Eligible toddy tappers	Age 50 and above; member of a Toddy Co-operative Society (TCS) or an individual tapper under the Tree For Tappers (TFT) scheme who had completed 50 years of age as on 1.2.2009. Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.4,000 per month (raised from Rs.3,000 by G.O.Ms.No.43 dt 13.06.2024).	Payable from 01.04.2024; disbursed from 01.07.2024 with arrears	https://sspensions.ap.gov.in/SSP/Home/About	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	About page shows superseded rates. Same exclusions as AP002.	2026-10-09	Verified on official government source(s) listed
AP007	NTR Bharosa Pension – Fishermen Pension	Pension / Fisheries	Eligible fishermen	Fisherman aged 50 years or above. Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.4,000 per month (raised from Rs.3,000 by G.O.Ms.No.43 dt 13.06.2024).	Payable from 01.04.2024; disbursed from 01.07.2024 with arrears	https://sspensions.ap.gov.in/SSP/Home/About	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	About page shows superseded rates. Same exclusions as AP002.	2026-10-09	Verified on official government source(s) listed
AP008	NTR Bharosa Pension – Traditional Cobbler Pension	Pension / Occupational	Eligible traditional cobblers	Traditional cobbler above 40 years of age. Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.4,000 per month (raised from Rs.3,000 by G.O.Ms.No.43 dt 13.06.2024).	Payable from 01.04.2024; disbursed from 01.07.2024 with arrears	https://sspensions.ap.gov.in/SSP/Home/About	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	About page shows superseded rates. Same exclusions as AP002.	2026-10-09	Verified on official government source(s) listed
AP009	NTR Bharosa Pension – Transgender Pension	Pension / Social welfare	Eligible transgender residents	Transgender person aged 18 years or above. Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.4,000 per month (raised from Rs.3,000 by G.O.Ms.No.43 dt 13.06.2024).	Payable from 01.04.2024; disbursed from 01.07.2024 with arrears	https://sspensions.ap.gov.in/SSP/Home/About	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	Sensitive personal information must be optional and handled respectfully. About page shows superseded rates. Same exclusions as AP002.	2026-10-09	Verified on official government source(s) listed
AP010	NTR Bharosa Pension – Single Women Pension	Pension / Women	Eligible single women	Married women who are separated or deserted: above 35 years of age and separation period more than 1 year as on date of sanction. Unmarried women: 30 years and above in rural areas or 35 years and above in urban areas, with no support of the family. Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.4,000 per month (raised from Rs.3,000 by G.O.Ms.No.43 dt 13.06.2024).	Payable from 01.04.2024; disbursed from 01.07.2024 with arrears	https://sspensions.ap.gov.in/SSP/Home/About	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	Do not use one age threshold for every applicant. About page shows superseded rates. Same exclusions as AP002.	2026-10-09	Verified on official government source(s) listed
AP011	NTR Bharosa Pension – ART/PLHIV Pension	Pension / Health-related	Eligible persons receiving ART treatment	No age limit; 6 months of continuous treatment on ART (Anti Retroviral Therapy). Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.4,000 per month (raised from Rs.3,000 by G.O.Ms.No.43 dt 13.06.2024).	Payable from 01.04.2024; disbursed from 01.07.2024 with arrears	https://sspensions.ap.gov.in/SSP/Home/About	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	Health information is sensitive; avoid collecting it unless strictly necessary. About page shows superseded rates. Same exclusions as AP002.	2026-10-09	Verified on official government source(s) listed
AP012	NTR Bharosa Pension – CKDU Pension	Pension / Health-related	Eligible persons with specified chronic kidney disease conditions	No age limit. SSP About page: patients undergoing continuous kidney dialysis (CKDU - Chronic Kidney Disease of Unknown etiology). G.O.Ms.No.43 also covers non-dialysis CKDU: CKD with serum creatinine above 5 mg; CKD with estimated GFR below 15 ml; CKD with small contracted kidney. Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.10,000 per month for CKDU on dialysis (government or private hospital) and for the non-dialysis CKDU categories above (non-dialysis raised from Rs.5,000). G.O.Ms.No.43 dt 13.06.2024.	Non-dialysis enhancement disbursed from 01.07.2024; dialysis categories no change	https://sspensions.ap.gov.in/SSP/Home/About	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	Do not ask users to enter detailed medical records in the initial prototype. The same G.O. also lists Rs.10,000 for bilateral elephantiasis grade 4; kidney/liver/heart transplant; sickle cell disease; thalassemia; severe haemophilia - these are not in this CSV. Same exclusions as AP002.	2026-10-09	Verified on official government source(s) listed
AP013	NTR Bharosa Pension – Dappu Artist Pension	Pension / Arts	Eligible Dappu artists	Dappu artist above 50 years of age. Common to all pensions: BPL family holding white ration card; local resident of the district; not covered under any other pension scheme.	Rs.4,000 per month (raised from Rs.3,000 by G.O.Ms.No.43 dt 13.06.2024). The G.O. also lists a separate Rs.4,000 pension to artists.	Payable from 01.04.2024; disbursed from 01.07.2024 with arrears	https://sspensions.ap.gov.in/SSP/Home/About	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	About page shows Rs.3,000 which is superseded. Same exclusions as AP002.	2026-10-09	Verified on official government source(s) listed
AP014	Free Power for Handloom Weaver Households	Handlooms / Utilities	Eligible handloom weaver households	Permanent resident of Andhra Pradesh; individual weaver engaged in handloom weaving; loom operational and used solely for weaving; valid Weaver Certificate from the Dept of Handlooms and Textiles or Weaver Pehchan Card issued by Govt of India; no pending dues or arrears with the DISCOM at enrolment. Documents: Aadhaar, weaver certificate or Weaver Pehchan Card, latest electricity bill, bank details, self-declaration that the connection is used exclusively for weaving; tenants need an indemnity bond from the registered consumer.	Free power up to 200 units per month; subsidy adjusted automatically in the monthly electricity bill; consumption above the limit is paid by the applicant.	Orders to implement from 01.04.2026 (G.O.Ms.No.44 Industries and Commerce (Prog-II) dt 26.03.2025)	https://handlooms.ap.gov.in/stateschemes.html	https://handlooms.ap.gov.in/documents/Approved_SoP.pdf	Apply at the nearest Assistant Engineer office of the concerned section; officials of the Electricity Dept and District Handlooms and Textiles Office verify jointly. Subsidy stops if the household is found not engaged in weaving.	2026-10-09	Verified on official government source(s) listed
AP015	Free Power for Powerloom Units	Handlooms / Utilities	Eligible powerloom units	Permanent resident of Andhra Pradesh; powerloom unit holder engaged in power-operated weaving; loom operational and used solely for weaving; valid Powerloom Registration Certificate (SSI registration or other certificate recognising the unit); no pending dues or arrears with the DISCOM at enrolment. Other documents as for AP014.	Free power up to 500 units per month; subsidy adjusted in the monthly electricity bill; consumption above the limit is paid by the unit.	Orders to implement from 01.04.2026 (G.O.Ms.No.44 Industries and Commerce (Prog-II) dt 26.03.2025)	https://handlooms.ap.gov.in/stateschemes.html	https://handlooms.ap.gov.in/documents/Approved_SoP.pdf	Same application route and compliance rules as AP014.	2026-10-09	Verified on official government source(s) listed
AP016	Co-operative Handloom Weavers Thrift Fund Scheme	Handlooms / Savings support	Weaver members of Primary Handloom Weavers Co-operative Societies	Aim: to inculcate thrift habit among weaver members of Primary Handloom Weavers Co-operative Societies.	Government matching share enhanced from 8% to 16% (G.O.Ms.No.35 Industries and Commerce (Prog.II) dt 11.02.2019).	Matching share w.e.f. 01.04.2019; scheme being implemented from financial year 2024-25	https://handlooms.ap.gov.in/stateschemes.html	\N	Do not infer benefits beyond the matching share without the latest orders.	2026-10-09	Verified on official government source(s) listed
AP017	Cash Credit to Primary Handloom Weavers Co-operative Societies	Handlooms / Institutional finance	Primary Handloom Weavers Co-operative Societies (PHWCSs)	Society-level scheme; not an individual citizen benefit.	Working capital finance for production and marketing of cloth extended to PHWCSs through District Co-operative Central Banks.	Not stated on the page	https://handlooms.ap.gov.in/stateschemes.html	\N	May be excluded from the citizen-facing individual eligibility checker.	2026-10-09	Verified on official government source(s) listed
AP020	Stree Shakti Free Bus Travel Scheme	Transport / Women and transgender citizens	Girls, women and transgender citizens domiciled in Andhra Pradesh	Free bus travel for all girls, women and transgender citizens domiciled in Andhra Pradesh, with valid ID proof. Applicable to Pallevelugu, Ultra Pallevelugu, City Ordinary, Metro Express and Express services. Not applicable to Non-stop, Interstate, Contract Carriage, Chartered services and Package Tours. Permitted in Enclave routes.	Free travel on the covered APSRTC services; APSRTC estimates about Rs.1,000 per month saving per family.	Launched 15 August 2025 (G.O.Ms.No.27 T,R&B (PTD.I) Dept dt 11.08.2025)	https://www.apsrtc.ap.gov.in/coverage.php	\N	Do not promise every bus or service is covered.	2026-10-09	Verified on official government source(s) listed
\.


--
-- Data for Name: sources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sources (source_id, scheme_id, source_url, source_type, last_checked_at) FROM stdin;
1	AP001	https://tirupati.ap.gov.in/social-welfare/	primary	2026-10-09
2	AP002	https://sspensions.ap.gov.in/SSP/Home/About	primary	2026-10-09
3	AP003	https://sspensions.ap.gov.in/SSP/Home/About	primary	2026-10-09
4	AP004	https://sspensions.ap.gov.in/SSP/Home/About	primary	2026-10-09
5	AP005	https://handlooms.ap.gov.in/stateschemes.html	primary	2026-10-09
6	AP006	https://sspensions.ap.gov.in/SSP/Home/About	primary	2026-10-09
7	AP007	https://sspensions.ap.gov.in/SSP/Home/About	primary	2026-10-09
8	AP008	https://sspensions.ap.gov.in/SSP/Home/About	primary	2026-10-09
9	AP009	https://sspensions.ap.gov.in/SSP/Home/About	primary	2026-10-09
10	AP010	https://sspensions.ap.gov.in/SSP/Home/About	primary	2026-10-09
11	AP011	https://sspensions.ap.gov.in/SSP/Home/About	primary	2026-10-09
12	AP012	https://sspensions.ap.gov.in/SSP/Home/About	primary	2026-10-09
13	AP013	https://sspensions.ap.gov.in/SSP/Home/About	primary	2026-10-09
14	AP014	https://handlooms.ap.gov.in/stateschemes.html	primary	2026-10-09
15	AP015	https://handlooms.ap.gov.in/stateschemes.html	primary	2026-10-09
16	AP016	https://handlooms.ap.gov.in/stateschemes.html	primary	2026-10-09
17	AP017	https://handlooms.ap.gov.in/stateschemes.html	primary	2026-10-09
18	AP020	https://www.apsrtc.ap.gov.in/coverage.php	primary	2026-10-09
19	AP001	https://jnanabhumi.ap.gov.in/GOs/2024SW_MS87.pdf	supporting	2026-10-09
20	AP001	https://jnanabhumi.ap.gov.in/	supporting	2026-10-09
21	AP002	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	supporting	2026-10-09
22	AP002	https://sspensions.ap.gov.in/SSP/Home/Index	supporting	2026-10-09
23	AP002	https://eluru.ap.gov.in/?p=37682	supporting	2026-10-09
24	AP003	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	supporting	2026-10-09
25	AP004	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	supporting	2026-10-09
26	AP004	https://sspensions.ap.gov.in/SSP/Home/Index	supporting	2026-10-09
27	AP004	https://eluru.ap.gov.in/?p=37682	supporting	2026-10-09
28	AP005	https://sspensions.ap.gov.in/SSP/Home/About	supporting	2026-10-09
29	AP005	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	supporting	2026-10-09
30	AP006	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	supporting	2026-10-09
31	AP007	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	supporting	2026-10-09
32	AP008	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	supporting	2026-10-09
33	AP009	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	supporting	2026-10-09
34	AP010	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	supporting	2026-10-09
35	AP011	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	supporting	2026-10-09
36	AP012	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	supporting	2026-10-09
37	AP013	https://sspensions.ap.gov.in/SSP/Documents/GO%20MS%2043%2013.06.2024.pdf	supporting	2026-10-09
38	AP014	https://handlooms.ap.gov.in/documents/Approved_SoP.pdf	supporting	2026-10-09
39	AP015	https://handlooms.ap.gov.in/documents/Approved_SoP.pdf	supporting	2026-10-09
\.


--
-- Name: eligibility_rules_rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eligibility_rules_rule_id_seq', 51, true);


--
-- Name: required_documents_document_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.required_documents_document_id_seq', 1, false);


--
-- Name: sources_source_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sources_source_id_seq', 39, true);


--
-- Name: eligibility_rules eligibility_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eligibility_rules
    ADD CONSTRAINT eligibility_rules_pkey PRIMARY KEY (rule_id);


--
-- Name: required_documents required_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_documents
    ADD CONSTRAINT required_documents_pkey PRIMARY KEY (document_id);


--
-- Name: schemes schemes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schemes
    ADD CONSTRAINT schemes_pkey PRIMARY KEY (scheme_id);


--
-- Name: sources sources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sources
    ADD CONSTRAINT sources_pkey PRIMARY KEY (source_id);


--
-- Name: eligibility_rules eligibility_rules_scheme_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eligibility_rules
    ADD CONSTRAINT eligibility_rules_scheme_id_fkey FOREIGN KEY (scheme_id) REFERENCES public.schemes(scheme_id);


--
-- Name: required_documents required_documents_scheme_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_documents
    ADD CONSTRAINT required_documents_scheme_id_fkey FOREIGN KEY (scheme_id) REFERENCES public.schemes(scheme_id);


--
-- Name: sources sources_scheme_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sources
    ADD CONSTRAINT sources_scheme_id_fkey FOREIGN KEY (scheme_id) REFERENCES public.schemes(scheme_id);


--
-- PostgreSQL database dump complete
--

\unrestrict Jvjus86awmwqzWcMg2aaw5eSxWNrEXnPUCGkPBkGn9kXJimIH4QyHgjOIPj3WsN

