--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.10
-- Dumped by pg_dump version 9.6.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: association_spot_guidebook; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.association_spot_guidebook (
    spot_id integer NOT NULL,
    guidebook_id integer NOT NULL
);


ALTER TABLE public.association_spot_guidebook OWNER TO admin;

--
-- Name: booking; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.booking (
    id integer NOT NULL,
    booked_by character varying(100) NOT NULL,
    date_from date NOT NULL,
    date_until date NOT NULL,
    email character varying(100),
    phone character varying(30),
    member_librairy_id integer NOT NULL
);


ALTER TABLE public.booking OWNER TO admin;

--
-- Name: booking_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.booking_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.booking_id_seq OWNER TO admin;

--
-- Name: booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.booking_id_seq OWNED BY public.booking.id;


--
-- Name: comment_spot; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.comment_spot (
    id integer NOT NULL,
    comment text NOT NULL,
    member_id integer NOT NULL,
    spot_id integer NOT NULL,
    date date NOT NULL
);


ALTER TABLE public.comment_spot OWNER TO admin;

--
-- Name: comment_spot_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.comment_spot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_spot_id_seq OWNER TO admin;

--
-- Name: comment_spot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.comment_spot_id_seq OWNED BY public.comment_spot.id;


--
-- Name: guidebook; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.guidebook (
    id integer NOT NULL,
    isbn13 character(13) NOT NULL,
    name text NOT NULL,
    year_publication smallint,
    publisher character varying(50),
    language character varying(50),
    summary text,
    firstname_author character varying(30),
    surname_author character varying(50)
);


ALTER TABLE public.guidebook OWNER TO admin;

--
-- Name: guidebook_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.guidebook_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guidebook_id_seq OWNER TO admin;

--
-- Name: guidebook_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.guidebook_id_seq OWNED BY public.guidebook.id;


--
-- Name: id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.id_seq OWNER TO admin;

--
-- Name: location; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.location (
    id integer DEFAULT nextval('public.id_seq'::regclass) NOT NULL,
    region character varying(30) NOT NULL,
    departement_name character varying(30) NOT NULL,
    departement_id character(3) NOT NULL,
    city_name character varying(30) NOT NULL,
    zip_code character(5) NOT NULL
);


ALTER TABLE public.location OWNER TO admin;

--
-- Name: member; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.member (
    id integer NOT NULL,
    first_name character varying(30) NOT NULL,
    surname character varying(50) NOT NULL,
    nickname character varying(20) NOT NULL,
    password character varying(20) NOT NULL,
    email character varying(100) DEFAULT ''::character varying NOT NULL,
    phone character varying(30),
    date_membership timestamp without time zone NOT NULL
);


ALTER TABLE public.member OWNER TO admin;

--
-- Name: member_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.member_id_seq OWNER TO admin;

--
-- Name: member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.member_id_seq OWNED BY public.member.id;


--
-- Name: member_librairy; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.member_librairy (
    member_id integer NOT NULL,
    guidebook_id integer NOT NULL,
    id integer DEFAULT nextval('public.id_seq'::regclass) NOT NULL
);


ALTER TABLE public.member_librairy OWNER TO admin;

--
-- Name: route; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.route (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    nb_pitch smallint NOT NULL,
    index_pitch smallint NOT NULL,
    rating character varying(4) NOT NULL,
    spot_id integer NOT NULL,
    nb_anchor integer NOT NULL
);


ALTER TABLE public.route OWNER TO admin;

--
-- Name: route_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.route_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.route_id_seq OWNER TO admin;

--
-- Name: route_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.route_id_seq OWNED BY public.route.id;


--
-- Name: spot; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.spot (
    id integer DEFAULT nextval('public.id_seq'::regclass) NOT NULL,
    name_spot character varying(50) NOT NULL,
    name_area character varying(50),
    location_id integer NOT NULL,
    access text NOT NULL
);


ALTER TABLE public.spot OWNER TO admin;

--
-- Name: spot_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.spot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spot_id_seq OWNER TO admin;

--
-- Name: spot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.spot_id_seq OWNED BY public.spot.id;


--
-- Name: booking id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.booking ALTER COLUMN id SET DEFAULT nextval('public.booking_id_seq'::regclass);


--
-- Name: comment_spot id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.comment_spot ALTER COLUMN id SET DEFAULT nextval('public.comment_spot_id_seq'::regclass);


--
-- Name: guidebook id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.guidebook ALTER COLUMN id SET DEFAULT nextval('public.guidebook_id_seq'::regclass);


--
-- Name: member id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.member ALTER COLUMN id SET DEFAULT nextval('public.member_id_seq'::regclass);


--
-- Name: route id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.route ALTER COLUMN id SET DEFAULT nextval('public.route_id_seq'::regclass);


--
-- Data for Name: association_spot_guidebook; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.association_spot_guidebook (spot_id, guidebook_id) FROM stdin;
5	1
3	4
72	65
73	65
5	6
4	6
75	6
5	75
4	75
3	77
191	77
191	4
5	78
4	78
1	6
37	6
\.


--
-- Data for Name: booking; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.booking (id, booked_by, date_from, date_until, email, phone, member_librairy_id) FROM stdin;
126	Zaza	2019-08-03	2019-08-23	w@i.com	434287287382	172
5	pierre	2019-08-13	2019-08-20			110
127	Yvon	2019-09-06	2019-09-20			170
128	 Charles (voisin)	2019-08-01	2019-08-31	charli@yahoo.fr	 0385303955	194
9	Laurent	2019-09-01	2019-09-02			110
10	Lucie	2019-10-11	2019-10-20			110
21	Lucie	2019-09-26	2019-09-28			116
22	Pierre	2019-09-25	2019-09-27			116
26	Henri	2019-10-14	2019-10-28			116
110	Lulu	2019-11-05	2019-11-26			109
112	Lelette	2019-09-01	2019-09-08			109
113	Test	2019-10-01	2019-10-03			109
115	pour usage perso	2019-11-01	2019-11-22			123
109	Pierre	2019-09-23	2019-09-24			109
92	David Yuyu	2019-09-15	2019-09-22			109
121	Paulette	2019-09-05	2019-09-25	paupau@yahoo.fr	0380123987	172
122	Wilson	2019-09-18	2019-09-27	wilson@yahoo.fr	015765652435	186
123	Reza	2019-09-08	2019-09-16		015765652435	186
124	Diana (Berlin)	2019-11-15	2019-11-30		01576565245333	186
\.


--
-- Name: booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.booking_id_seq', 128, true);


--
-- Data for Name: comment_spot; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.comment_spot (id, comment, member_id, spot_id, date) FROM stdin;
1	J'ai découvert ce site durant mes vacances de 2004 et cela a été une révélation! Le site est absolument extraordinaire et comporte des voies adaptées à tous les niveaux. Je le recommande aux débutants comme aux grimpeurs plus expérimentés!	3	1	2019-08-15
2	Attention, la voie "soleil levant" de niveau 4 est clairement de niveau 5 voire 6. Je ne sais pas qui a fait la côtation mais cette voie est vraiment plus difficile qu'il n'y parait!	2	1	2019-08-17
81	Un site extraordinaire!	26	6	2019-03-25
84	J'ai suis allé dans les années à 80. Déjà à l'époque, la voie du colonnel était un must sur le secteur de Chamonix. Depuis la voie n'a pas perdu de sa superbe!	8	5	2019-09-01
85	J'ai adoré!	8	75	2019-08-26
86	Formidable	8	204	2019-08-26
87	Intéressant	8	4	2019-08-26
32	Un site fabuleux pour les enfants et les grands!!!PARFAIT	17	124	2019-09-03
34	Comme le signale justement Caropic, attention avec la voie soleil levant. Quand j'y étais la semaine dernière un accident venait de se produire. Donc méfiance!	17	1	2019-09-01
49	Un groupe de passionnés est en train d'ouvrir ce site. A suivre.	8	175	2019-08-13
54	Pas génial...	8	72	2019-08-14
55	pourri	8	72	2019-08-14
56	Pas mal. 	8	37	2019-08-14
57	Bof.	8	37	2019-08-14
58	Pourquoi pas...	8	37	2019-08-14
59	Personnellement très déçu.	8	4	2019-08-14
62	Le Mont-Blanc envahi de grimpeurs en tongs. A fuir.	8	4	2019-08-17
63	Extraordinaire. 	8	181	2019-08-17
65	Un site familial. Peu de voies, mais des voies de grandes qualités. A réserver à un public expérimenté. 	8	184	2019-03-17
66	Très bon site. Facilement accessible depuis Lyon. 	8	124	2019-08-28
68	Un niveau 4 intéressant pour les débutants	8	75	2019-09-28
69	Sympa	23	5	2019-08-20
70	Intéressant pour les enfants. 	23	124	2019-08-30
71	Très décevant. 	23	72	2019-08-30
72	Un de mes sites préférés à la Réunion!	8	191	2019-08-30
\.


--
-- Name: comment_spot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.comment_spot_id_seq', 87, true);


--
-- Data for Name: guidebook; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.guidebook (id, isbn13, name, year_publication, publisher, language, summary, firstname_author, surname_author) FROM stdin;
4	9791034800582	Sous les brumes de Mafate	2018	Evidence Editions	Français	Un très bel ouvrage.	Patrice	Noël-Richard
6	9782344005347	Haute Tarentaise: Aime, La Plagne, Peisey, Les Arcs, Bourg-Saint-Maurice, La Rosière, Sainte-Foy, Val d'Isère, Tignes	2015	Glénat Livres	Français	De Moûtiers à Tignes et Val d'Isère, entre Vanoise et Beaufortain s'étire la Haute Tarentaise. Mondialement connue pour ses stations de ski, cette vallée est à découvrir également en été, en douceur, au gré des 44 balades et petites randonnées proposées dans ce guide.\nAlpages, villages, lacs, la montagne est ici généreuse en destinations tout aussi belles et agréables les unes que les autres.	Jean	Gotteland
65	6754352435243	La vie éternelle	1982	Glénat	Français	Un ouvrage de référence!	Pierre	Saint-Patrick
66	6355535243748	Le vercors en hiver	1999	Glénat	Français	Un ouvrage de référence pour les amoureux du Vercors	Jean	Petit
1	9782723462105	Escalade choisies: mont-Blanc, Aiguilles Rouges	2009	Glénat	Français	Au cœur du massif du Mont-Blanc ou dans les Aiguilles Rouges, voici le meilleur de ce terrain de jeu, avec des critères de sélection hédonistes: beauté des sites, variété de style et de rocher, grimpe à la journée sur des voies n'excédant pas 300 m, approche et descentes aisées...	Jean-Charles	Laroche
75	4545555555454	La montagne	1930	Louc	français	Un ouvrage de référence.	Jean	Dubois
76	5555555445455	Test en montagne	1913	Le Peuplier	Français	Un classique	Pierre	Legrand
77	8765435241536	Mafate, quel cirque	2018	Petit futé	français	Un topo actuel pour grimper dans le cirque de Mafate	Jean	Gagalou
78	8765656565628	Belle montagne	2013	Glénat	français	Le classique de la montagne	Roger	Laplanche
\.


--
-- Name: guidebook_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.guidebook_id_seq', 79, true);


--
-- Name: id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.id_seq', 204, true);


--
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.location (id, region, departement_name, departement_id, city_name, zip_code) FROM stdin;
9	La Réunion	La Réunion	974	Saint-Benoît	97470
7	Auvergne-Rhône-Alpes	Haute-Savoie	74 	Chamonix-Mont-Blanc	74400
6	Auvergne-Rhône-Alpes	Savoie	73 	Courchevel	73120
5	Auvergne-Rhône-Alpes	Savoie	73 	La Plagne Tarentaise	73210
4	Auvergne-Rhône-Alpes	Savoie	73 	Aime-la-Plagne	73210
2	Occitanie	Lozère	48 	La Malène	48210
10	Auvergne-Rhône-Alpes	Ain	01 	Pont-de-Vaux	01190
74	Auvergne-Rhône-Alpes	Isère	38 	Miribel-Lanchâtre	38450
87	Auvergne-Rhône-Alpes	Rhône	69 	Dracé	69220
120	Hauts-de-France	Pas-de-Calais	62 	Berck	62600
127	Bourgogne-Franche-Comté	Doubs	25 	Fleurey	25190
174	Auvergne-Rhône-Alpes	Ain	01 	Reyssouze	01190
71	Grand Est	Ardennes	08 	Saint-Juvin	08250
180	Auvergne-Rhône-Alpes	Cantal	15 	Dienne	15300
182	Auvergne-Rhône-Alpes	Cantal	15 	Murat	15300
190	La Réunion	La Réunion	974	Sainte-Suzanne	97441
203	Auvergne-Rhône-Alpes	Ain	01 	Saint-Étienne-du-Bois	01370
\.


--
-- Data for Name: member; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.member (id, first_name, surname, nickname, password, email, phone, date_membership) FROM stdin;
2	Caroline	Pierre	Caropic	gygy654!	caroline@hotmail.com	0033611224352	2019-08-12 00:00:00
3	Quentin	Lassivière	QuentinL	rotor1111	quinine@hotmail.es	004915781870467	2019-08-22 00:00:00
17	Super	Admin	superadmin	superadmin	superadmin@admin.fr	015781870467	2019-08-17 10:26:32.06
23	Erdzhan	Ruzhdi	erico	soleil	erdzhan_ruzhdi@yahoo.bg	015781870467	2019-08-08 15:34:16.629
8	Julien	Berthoud	Juju	soleil	julien_berthoud@yahoo.fr	015781870467	2019-09-01 12:27:02.833
4	Roger	Black	Roger	yuyu89!	rogerroger@yahoo.fr		2019-08-12 00:00:00
26	Pierre	Dubuc	pdubuc	soleil	pdubuc@yahoo.fr	015783845263	2019-08-25 13:08:17.523
\.


--
-- Name: member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.member_id_seq', 26, true);


--
-- Data for Name: member_librairy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.member_librairy (member_id, guidebook_id, id) FROM stdin;
2	4	160
2	6	161
3	65	164
3	66	165
4	1	166
4	4	167
4	65	168
4	66	169
8	1	170
8	65	171
8	66	185
23	6	186
23	65	187
23	66	188
8	4	189
8	78	194
2	1	153
\.


--
-- Data for Name: route; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.route (id, name, nb_pitch, index_pitch, rating, spot_id, nb_anchor) FROM stdin;
10	2001 les doigts de l'espace	2	1	6	2	12
9	Les cerveaux lents	1	1	4	2	10
8	Terminator	1	1	8	1	12
7	Pierre qui roule	1	1	5	1	14
6	Soleil levant	1	1	4	1	16
5	Voie royale	1	1	4	1	26
4	Salamandre dorée	1	1	3a	3	15
40	2020 l'aventure	1	1	5	183	20
2	Soleil matinal	2	1	7	3	20
39	2030 La défi	1	1	6a	183	19
38	2020 l'aventure	1	1	5	183	16
14	Bêves blancs	1	1	8	4	26
35	Les aventuriers	1	1	4	175	20
30	La belle bleue	1	1	5	121	16
31	La belle rouge	1	1	6	121	14
29	Voie du renard	1	1	6	88	12
32	Doigts de fer	1	1	6	124	10
1	A tout pic	1	1	5b	3	23
25	Michu, on est peut plus!	1	1	4	72	23
24	Michu, t'es foutu	1	1	7	72	12
13	Ma voie de l'espoir atomique	1	1	5	4	10
19	Paravent royal	1	1	8	7	8
36	Les bressans	2	1	4	175	14
11	2001 les doigts de l'espace	2	2	7	2	10
21	La voie du colonnel	1	1	1	5	0
34	Les loupiots	2	2	7	128	0
33	Les loupiots	2	1	4	128	0
28	Coucou nous voilà	1	1	4	75	0
26	Nous revoila	1	1	4	73	0
18	Speed runner	1	1	6	6	0
17	Batman	1	1	7	6	0
3	Coup de sang	2	2	9	3	0
37	Les bressans	2	2	9	175	0
46	Voie bleue	1	1	6	204	23
47	Voie rouge	1	1	9	204	0
\.


--
-- Name: route_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.route_id_seq', 47, true);


--
-- Data for Name: spot; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.spot (id, name_spot, name_area, location_id, access) FROM stdin;
5	Mont-Blanc	Ouestine Célestinette	7	Le site se situe à la sortie du village, sur la D322. Tourner à gauche après la station service Total et continuer tout droit en direction du col du Grand Vélibier.   
4	Mont-Blanc	Sud-Ouest	7	Le site se situe à la sortie du village, sur la D329. Tourner à droite après la station service Total et continuer tout droit en direction du col du Grand Vélibier.  
191	Cirque de Mafate		190	À la sortie de Sainte-Suzanne, prendre la route communale en direction du volcan. L'emplacement du parking est bien indiqué. 
181	Le Puy Mary		180	Le site se trouve à l'entrée de Dienne, sur la D34.
183	Bellevue		182	Par la D23 en direction de Dienne
184	Bellevue		182	Par la D23 en direction de Dienne
1	Site de la Ravière		5	Le site se situe à la sortie du village, sur la D325. Tourner à droite après la station service Total et continuer tout droit en direction du col du Grand Vélibier. 
121	Grimpberck		120	Le site se situe à la sortie du village, sur la D325. Tourner à droite après la station service Total et continuer tout droit en direction du col du Grand Vélibier. 
7	Les Paravents		2	Le site se situe à la sortie du village, sur la D325. Tourner à droite après la station service Total et continuer tout droit en direction du col du Grand Vélibier. 
6	Beau soleil		6	Le site se situe à la sortie du village, sur la D325. Tourner à droite après la station service Total et continuer tout droit en direction du col du Grand Vélibier. 
3	Falaise de Basse Vallée		9	Le site se situe à la sortie du village, sur la D325. Tourner à droite après la station service Total et continuer tout droit en direction du col du Grand Vélibier. 
2	Site de la Grande Roche		4	Le site se situe à la sortie du village, sur la D325. Tourner à droite après la station service Total et continuer tout droit en direction du col du Grand Vélibier. 
204	Le beau site		203	D342
175	Les cabanis		174	Le site se situe à la sortie du village, sur la D325. Tourner à droite après la station service Total et continuer tout droit en direction du col du Grand Vélibier. 
128	Les Loups-Garous		127	Le site se situe à la sortie du village, sur la D325. Tourner à droite après la station service Total et continuer tout droit en direction du col du Grand Vélibier. 
124	La grimpette	nord	10	Le site se situe à la sortie du village, sur la D325. Tourner à droite après la station service Total et continuer tout droit en direction du col du Grand Vélibier. 
88	Site des verts	Sud	87	Le site se situe à la sortie du village, sur la D325. Tourner à droite après la station service Total et continuer tout droit en direction du col du Grand Vélibier. 
75	Les morilles	Sud	74	Le site se situe à la sortie du village, sur la D325. Tourner à droite après la station service Total et continuer tout droit en direction du col du Grand Vélibier. 
73	La poste michue	Est	71	Le site se situe à la sortie du village, sur la D325. Tourner à droite après la station service Total et continuer tout droit en direction du col du Grand Vélibier. 
72	Le poste michue	Ouest	71	Le site se situe à la sortie du village, sur la D325. Tourner à droite après la station service Total et continuer tout droit en direction du col du Grand Vélibier. 
37	Les chamelles rouges	Sud	5	Le site se situe à la sortie du village, sur la D325. Tourner à droite après la station service Total et continuer tout droit en direction du col du Grand Vélibier. 
\.


--
-- Name: spot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.spot_id_seq', 9, false);


--
-- Name: association_spot_guidebook association_spot_guidebook_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.association_spot_guidebook
    ADD CONSTRAINT association_spot_guidebook_pk PRIMARY KEY (spot_id, guidebook_id);


--
-- Name: booking booking_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pk PRIMARY KEY (id);


--
-- Name: comment_spot comment_spot_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.comment_spot
    ADD CONSTRAINT comment_spot_pk PRIMARY KEY (id);


--
-- Name: guidebook guidebook_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.guidebook
    ADD CONSTRAINT guidebook_pk PRIMARY KEY (id);


--
-- Name: location location_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.location
    ADD CONSTRAINT location_pk PRIMARY KEY (id);


--
-- Name: member_librairy member_librairy_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.member_librairy
    ADD CONSTRAINT member_librairy_pkey PRIMARY KEY (id);


--
-- Name: member member_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT member_pk PRIMARY KEY (id);


--
-- Name: route route_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT route_pk PRIMARY KEY (id);


--
-- Name: spot spot_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.spot
    ADD CONSTRAINT spot_pk PRIMARY KEY (id);


--
-- Name: email; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX email ON public.member USING btree (email);


--
-- Name: nickname; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX nickname ON public.member USING btree (nickname);


--
-- Name: association_spot_guidebook association_spot_guidebook_guidebook_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.association_spot_guidebook
    ADD CONSTRAINT association_spot_guidebook_guidebook_id_fkey FOREIGN KEY (guidebook_id) REFERENCES public.guidebook(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: association_spot_guidebook association_spot_guidebook_spot_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.association_spot_guidebook
    ADD CONSTRAINT association_spot_guidebook_spot_id_fkey FOREIGN KEY (spot_id) REFERENCES public.spot(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: comment_spot comment_spot_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.comment_spot
    ADD CONSTRAINT comment_spot_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.member(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: comment_spot comment_spot_spot_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.comment_spot
    ADD CONSTRAINT comment_spot_spot_id_fkey FOREIGN KEY (spot_id) REFERENCES public.spot(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: member_librairy member_librairy_guidebook_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.member_librairy
    ADD CONSTRAINT member_librairy_guidebook_id_fkey FOREIGN KEY (guidebook_id) REFERENCES public.guidebook(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: member_librairy member_librairy_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.member_librairy
    ADD CONSTRAINT member_librairy_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.member(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: route route_spot_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT route_spot_id_fkey FOREIGN KEY (spot_id) REFERENCES public.spot(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spot spot_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.spot
    ADD CONSTRAINT spot_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.location(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

