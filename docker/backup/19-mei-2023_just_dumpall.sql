--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE person;
ALTER ROLE person WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5ca6269721a2eddb8ed1c52206ddc58d1';
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md5285131dbc5653e8654c14d381ca6cc53';
ALTER ROLE person SET client_encoding TO 'utf8';
ALTER ROLE person SET default_transaction_isolation TO 'read committed';






--
-- Database creation
--

CREATE DATABASE "philo-b" WITH TEMPLATE = template0 OWNER = postgres;
GRANT ALL ON DATABASE "philo-b" TO person;
REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


\connect -reuse-previous=on "dbname='philo-b'"

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.13 (Debian 10.13-1.pgdg90+1)
-- Dumped by pg_dump version 10.13 (Debian 10.13-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
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
-- Name: account_emailaddress; Type: TABLE; Schema: public; Owner: person
--

CREATE TABLE public.account_emailaddress (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    verified boolean NOT NULL,
    "primary" boolean NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.account_emailaddress OWNER TO person;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: person
--

CREATE SEQUENCE public.account_emailaddress_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_emailaddress_id_seq OWNER TO person;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: person
--

ALTER SEQUENCE public.account_emailaddress_id_seq OWNED BY public.account_emailaddress.id;


--
-- Name: account_emailconfirmation; Type: TABLE; Schema: public; Owner: person
--

CREATE TABLE public.account_emailconfirmation (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    sent timestamp with time zone,
    key character varying(64) NOT NULL,
    email_address_id integer NOT NULL
);


ALTER TABLE public.account_emailconfirmation OWNER TO person;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE; Schema: public; Owner: person
--

CREATE SEQUENCE public.account_emailconfirmation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_emailconfirmation_id_seq OWNER TO person;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: person
--

ALTER SEQUENCE public.account_emailconfirmation_id_seq OWNED BY public.account_emailconfirmation.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: person
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO person;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: person
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO person;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: person
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: person
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO person;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: person
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO person;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: person
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: person
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO person;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: person
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO person;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: person
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: blog_blog; Type: TABLE; Schema: public; Owner: person
--

CREATE TABLE public.blog_blog (
    id integer NOT NULL,
    short_title character varying(100) NOT NULL,
    slug character varying(100) NOT NULL,
    title character varying(200) NOT NULL,
    summary text,
    content text,
    posted timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL
);


ALTER TABLE public.blog_blog OWNER TO person;

--
-- Name: blog_blog_id_seq; Type: SEQUENCE; Schema: public; Owner: person
--

CREATE SEQUENCE public.blog_blog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blog_blog_id_seq OWNER TO person;

--
-- Name: blog_blog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: person
--

ALTER SEQUENCE public.blog_blog_id_seq OWNED BY public.blog_blog.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: person
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    path integer[] NOT NULL,
    cluster integer NOT NULL,
    content text NOT NULL,
    pub_date timestamp with time zone NOT NULL,
    is_first boolean NOT NULL,
    is_last boolean NOT NULL,
    author_id_id integer NOT NULL,
    post_id_id integer NOT NULL,
    edited timestamp with time zone NOT NULL
);


ALTER TABLE public.comments OWNER TO person;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: person
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO person;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: person
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: person
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO person;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: person
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO person;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: person
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: person
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO person;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: person
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO person;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: person
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: person
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO person;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: person
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO person;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: person
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: person
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO person;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: person
--

CREATE TABLE public.django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO person;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: person
--

CREATE SEQUENCE public.django_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO person;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: person
--

ALTER SEQUENCE public.django_site_id_seq OWNED BY public.django_site.id;


--
-- Name: socialaccount_socialaccount; Type: TABLE; Schema: public; Owner: person
--

CREATE TABLE public.socialaccount_socialaccount (
    id integer NOT NULL,
    provider character varying(30) NOT NULL,
    uid character varying(191) NOT NULL,
    last_login timestamp with time zone NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    extra_data text NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialaccount OWNER TO person;

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE; Schema: public; Owner: person
--

CREATE SEQUENCE public.socialaccount_socialaccount_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialaccount_id_seq OWNER TO person;

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: person
--

ALTER SEQUENCE public.socialaccount_socialaccount_id_seq OWNED BY public.socialaccount_socialaccount.id;


--
-- Name: socialaccount_socialapp; Type: TABLE; Schema: public; Owner: person
--

CREATE TABLE public.socialaccount_socialapp (
    id integer NOT NULL,
    provider character varying(30) NOT NULL,
    name character varying(40) NOT NULL,
    client_id character varying(191) NOT NULL,
    secret character varying(191) NOT NULL,
    key character varying(191) NOT NULL
);


ALTER TABLE public.socialaccount_socialapp OWNER TO person;

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE; Schema: public; Owner: person
--

CREATE SEQUENCE public.socialaccount_socialapp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialapp_id_seq OWNER TO person;

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: person
--

ALTER SEQUENCE public.socialaccount_socialapp_id_seq OWNED BY public.socialaccount_socialapp.id;


--
-- Name: socialaccount_socialapp_sites; Type: TABLE; Schema: public; Owner: person
--

CREATE TABLE public.socialaccount_socialapp_sites (
    id integer NOT NULL,
    socialapp_id integer NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialapp_sites OWNER TO person;

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: person
--

CREATE SEQUENCE public.socialaccount_socialapp_sites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialapp_sites_id_seq OWNER TO person;

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: person
--

ALTER SEQUENCE public.socialaccount_socialapp_sites_id_seq OWNED BY public.socialaccount_socialapp_sites.id;


--
-- Name: socialaccount_socialtoken; Type: TABLE; Schema: public; Owner: person
--

CREATE TABLE public.socialaccount_socialtoken (
    id integer NOT NULL,
    token text NOT NULL,
    token_secret text NOT NULL,
    expires_at timestamp with time zone,
    account_id integer NOT NULL,
    app_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialtoken OWNER TO person;

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: person
--

CREATE SEQUENCE public.socialaccount_socialtoken_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialtoken_id_seq OWNER TO person;

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: person
--

ALTER SEQUENCE public.socialaccount_socialtoken_id_seq OWNED BY public.socialaccount_socialtoken.id;


--
-- Name: users_customuser; Type: TABLE; Schema: public; Owner: person
--

CREATE TABLE public.users_customuser (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.users_customuser OWNER TO person;

--
-- Name: users_customuser_groups; Type: TABLE; Schema: public; Owner: person
--

CREATE TABLE public.users_customuser_groups (
    id integer NOT NULL,
    customuser_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.users_customuser_groups OWNER TO person;

--
-- Name: users_customuser_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: person
--

CREATE SEQUENCE public.users_customuser_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_customuser_groups_id_seq OWNER TO person;

--
-- Name: users_customuser_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: person
--

ALTER SEQUENCE public.users_customuser_groups_id_seq OWNED BY public.users_customuser_groups.id;


--
-- Name: users_customuser_id_seq; Type: SEQUENCE; Schema: public; Owner: person
--

CREATE SEQUENCE public.users_customuser_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_customuser_id_seq OWNER TO person;

--
-- Name: users_customuser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: person
--

ALTER SEQUENCE public.users_customuser_id_seq OWNED BY public.users_customuser.id;


--
-- Name: users_customuser_user_permissions; Type: TABLE; Schema: public; Owner: person
--

CREATE TABLE public.users_customuser_user_permissions (
    id integer NOT NULL,
    customuser_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.users_customuser_user_permissions OWNER TO person;

--
-- Name: users_customuser_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: person
--

CREATE SEQUENCE public.users_customuser_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_customuser_user_permissions_id_seq OWNER TO person;

--
-- Name: users_customuser_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: person
--

ALTER SEQUENCE public.users_customuser_user_permissions_id_seq OWNED BY public.users_customuser_user_permissions.id;


--
-- Name: account_emailaddress id; Type: DEFAULT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.account_emailaddress ALTER COLUMN id SET DEFAULT nextval('public.account_emailaddress_id_seq'::regclass);


--
-- Name: account_emailconfirmation id; Type: DEFAULT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.account_emailconfirmation ALTER COLUMN id SET DEFAULT nextval('public.account_emailconfirmation_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: blog_blog id; Type: DEFAULT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.blog_blog ALTER COLUMN id SET DEFAULT nextval('public.blog_blog_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: django_site id; Type: DEFAULT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.django_site ALTER COLUMN id SET DEFAULT nextval('public.django_site_id_seq'::regclass);


--
-- Name: socialaccount_socialaccount id; Type: DEFAULT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.socialaccount_socialaccount ALTER COLUMN id SET DEFAULT nextval('public.socialaccount_socialaccount_id_seq'::regclass);


--
-- Name: socialaccount_socialapp id; Type: DEFAULT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.socialaccount_socialapp ALTER COLUMN id SET DEFAULT nextval('public.socialaccount_socialapp_id_seq'::regclass);


--
-- Name: socialaccount_socialapp_sites id; Type: DEFAULT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites ALTER COLUMN id SET DEFAULT nextval('public.socialaccount_socialapp_sites_id_seq'::regclass);


--
-- Name: socialaccount_socialtoken id; Type: DEFAULT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.socialaccount_socialtoken ALTER COLUMN id SET DEFAULT nextval('public.socialaccount_socialtoken_id_seq'::regclass);


--
-- Name: users_customuser id; Type: DEFAULT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.users_customuser ALTER COLUMN id SET DEFAULT nextval('public.users_customuser_id_seq'::regclass);


--
-- Name: users_customuser_groups id; Type: DEFAULT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.users_customuser_groups ALTER COLUMN id SET DEFAULT nextval('public.users_customuser_groups_id_seq'::regclass);


--
-- Name: users_customuser_user_permissions id; Type: DEFAULT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.users_customuser_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.users_customuser_user_permissions_id_seq'::regclass);


--
-- Data for Name: account_emailaddress; Type: TABLE DATA; Schema: public; Owner: person
--

COPY public.account_emailaddress (id, email, verified, "primary", user_id) FROM stdin;
5	denniszethof@gmail.com	t	t	6
6	mmmmmmm@gmail.com	t	t	1
\.


--
-- Data for Name: account_emailconfirmation; Type: TABLE DATA; Schema: public; Owner: person
--

COPY public.account_emailconfirmation (id, created, sent, key, email_address_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: person
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: person
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: person
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add permission	1	add_permission
2	Can change permission	1	change_permission
3	Can delete permission	1	delete_permission
4	Can add group	2	add_group
5	Can change group	2	change_group
6	Can delete group	2	delete_group
7	Can add content type	3	add_contenttype
8	Can change content type	3	change_contenttype
9	Can delete content type	3	delete_contenttype
10	Can add session	4	add_session
11	Can change session	4	change_session
12	Can delete session	4	delete_session
13	Can add site	5	add_site
14	Can change site	5	change_site
15	Can delete site	5	delete_site
16	Can add log entry	6	add_logentry
17	Can change log entry	6	change_logentry
18	Can delete log entry	6	delete_logentry
19	Can add email confirmation	7	add_emailconfirmation
20	Can change email confirmation	7	change_emailconfirmation
21	Can delete email confirmation	7	delete_emailconfirmation
22	Can add email address	8	add_emailaddress
23	Can change email address	8	change_emailaddress
24	Can delete email address	8	delete_emailaddress
25	Can add social account	9	add_socialaccount
26	Can change social account	9	change_socialaccount
27	Can delete social account	9	delete_socialaccount
28	Can add social application	10	add_socialapp
29	Can change social application	10	change_socialapp
30	Can delete social application	10	delete_socialapp
31	Can add social application token	11	add_socialtoken
32	Can change social application token	11	change_socialtoken
33	Can delete social application token	11	delete_socialtoken
34	Can add user	12	add_customuser
35	Can change user	12	change_customuser
36	Can delete user	12	delete_customuser
37	Can add blog	13	add_blog
38	Can change blog	13	change_blog
39	Can delete blog	13	delete_blog
40	Can add comment	14	add_comment
41	Can change comment	14	change_comment
42	Can delete comment	14	delete_comment
\.


--
-- Data for Name: blog_blog; Type: TABLE DATA; Schema: public; Owner: person
--

COPY public.blog_blog (id, short_title, slug, title, summary, content, posted, updated) FROM stdin;
3	Integer Varius Enim	Integer-varius-enim	<h1 class="main-title">Integer Varius Enim</h1>	no sum	<hr class="hr-text" />\r\n<h3><strong>Pharetra tempus</strong></h3>\r\n\r\n<p>Integer varius enim ut massa luctus pellentesque. Curabitur non arcu aliquam, sagittis tellus in, tempor risus. Aliquam faucibus eget elit commodo auctor. Fusce et ornare tortor. Pellentesque eget ex tristique, lobortis diam nec, pretium lacus. Ut eget interdum sem, non placerat purus. Nulla sed malesuada elit, nec placerat felis. Sed neque massa, egestas in neque id, pulvinar facilisis ligula. Fusce sagittis scelerisque nisi, ut convallis ipsum lacinia ut. Duis tristique sapien vitae ultrices placerat. Nullam vulputate nisl sit amet sapien pellentesque eleifend et eget nunc. Suspendisse potenti. In pharetra tristique diam ac facilisis.</p>\r\n<br />\r\n<img alt="" class="img-centered" src="/philo-b/media/ckuploads/2019/02/04/pexels-photo-1414694.png" />\r\n<div class="img-text">Fusce sagittis scelerisque</div>\r\n\r\n<p>Nullam tincidunt eleifend orci sed interdum. Nunc vehicula elit enim, congue hendrerit ex laoreet sed. Mauris eget ante id turpis tristique imperdiet. Morbi id metus ex. Donec massa nunc, lobortis in feugiat lacinia, porta non est. Vivamus quis velit non massa porta congue at vitae libero. In hac habitasse platea dictumst. Integer non egestas est. Suspendisse tempus suscipit augue ut eleifend. Aliquam consectetur orci at nibh commodo, sollicitudin molestie nisl euismod. Morbi porta, tellus id congue fermentum, dui augue volutpat justo, eget ultricies elit dui eu erat.</p>\r\n<br />\r\n<img alt="" class="img-centered" src="/philo-b/media/ckuploads/2019/02/04/pexels-photo-1414702.png" />\r\n<div class="img-text">At nibh commodo</div>\r\n\r\n<h3><strong>Sed volutpat hendrerit</strong></h3>\r\n\r\n<p>Duis elementum enim quis laoreet viverra. Cras pretium nisi sed dui auctor iaculis id et velit. Nulla sagittis leo ut magna auctor tristique. Cras consequat ex at rutrum consequat. Duis ornare eros leo, eget feugiat ipsum egestas non. Integer bibendum ex nibh, eget rutrum orci pulvinar et. Vivamus ex tellus, faucibus a mi et, luctus venenatis mi. Duis mi risus, sodales eget justo rutrum, elementum pulvinar ex. Fusce condimentum mattis ipsum suscipit condimentum. Pellentesque ex sem, convallis et urna nec, luctus fermentum magna. Proin est neque, sagittis ut aliquam a, fringilla vitae ante. Curabitur finibus tempor justo nec dapibus. Suspendisse dictum arcu sit amet erat ultricies hendrerit. Vestibulum lacus est, lobortis ac posuere at, euismod in nunc. Ut vehicula tellus a tortor convallis malesuada. Ut elementum, purus sed venenatis aliquam, diam elit viverra dui, nec rutrum eros ipsum eget tortor.</p>\r\n<br />\r\n<img alt="" class="img-centered" src="/philo-b/media/ckuploads/2019/02/04/pexels-photo-1383813.jpeg" />\r\n<div class="img-text">Mattis ipsum suscipit</div>\r\n\r\n<p>Vestibulum placerat posuere erat, auctor ullamcorper libero dapibus vel. Suspendisse quis aliquet ex. Vivamus hendrerit in neque vitae eleifend. Nullam lacinia ac ipsum sit amet porta. Vestibulum id sodales nisi. Vestibulum consectetur euismod turpis. Nam molestie eget augue a lacinia.</p>	2019-02-04 02:02:23.139065+00	2020-07-20 03:03:12.292594+00
5	Curabitur Tortor Nisl	Curabitur-tortor-nisl	<h1 class="main-title">Curabitur Tortor Nisl</h1>	no summ	<hr />\r\n<h3><strong>Proin ac dapibus</strong></h3>\r\n<img alt="" class="img-centered" src="/philo-b/media/ckuploads/2019/02/04/pexels-photo-844526.jpeg" />\r\n<div class="img-text">Tristique pulvinar</div>\r\n\r\n<p>Curabitur tortor nisl, condimentum ac risus sed, sagittis tincidunt lectus. Morbi tristique pulvinar odio ut feugiat. Duis quis lobortis neque. Morbi nisl nunc, mollis at justo in, pulvinar lobortis nunc. In scelerisque sed libero sed bibendum. Proin placerat, mi eget posuere gravida, dolor mauris faucibus nibh, suscipit euismod elit est nec felis. Ut placerat pellentesque elementum. Nunc tempor malesuada neque vel venenatis. Nulla congue ligula sem, dignissim tincidunt nisi ullamcorper quis. Aliquam erat volutpat. Integer pellentesque dignissim commodo. Cras condimentum tortor at nunc faucibus, ac laoreet urna feugiat. In a bibendum risus. Fusce facilisis enim nisl, vitae imperdiet quam dapibus a. Nam convallis justo velit, id convallis arcu consequat vel.</p>\r\n<br />\r\n<img alt="" class="img-centered" src="/philo-b/media/ckuploads/2019/02/04/pexels-photo-1840102.jpeg" />\r\n<div class="img-text">Class aptent</div>\r\n\r\n<p>Donec fringilla lectus rutrum egestas laoreet. Praesent in pellentesque erat. Proin ac dapibus turpis, quis tincidunt dolor. Phasellus ut diam neque. Nunc auctor auctor purus, nec faucibus magna tincidunt maximus. Nunc vitae est accumsan diam condimentum posuere. Maecenas ullamcorper, metus in bibendum dapibus, magna tortor consectetur justo, vel pulvinar enim neque aliquet elit. Nulla ullamcorper erat eu ligula faucibus, id ullamcorper risus mattis. Proin sapien urna, gravida a lorem quis, finibus bibendum ligula. Vivamus placerat dolor ut tincidunt dapibus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Morbi at dolor nec tortor varius feugiat vel a quam. Sed fermentum eros est, malesuada pharetra neque faucibus ac.</p>\r\n<br />\r\n<img alt="" class="img-centered" src="/philo-b/media/ckuploads/2019/02/04/large_jtl2eigp8ng0lwyt3pwbfwc1wrbkm9ygmq1o5vsdba8.jpg" style="max-width: 120%; margin-left: -10%; white-space: nowrap;" />\r\n<div class="img-text" style="margin-right:-10%;">Etiam efficitur</div>\r\n\r\n<p>Curabitur accumsan suscipit quam at gravida. Aenean nec ornare lorem. Cras maximus, purus ac bibendum ullamcorper, mauris purus semper libero, vel malesuada leo sem a velit. Morbi porta leo fringilla vehicula fermentum. Integer interdum urna vitae interdum bibendum. In pharetra ante ut dictum rhoncus. Pellentesque consectetur, quam at venenatis ullamcorper, magna sapien euismod mi, et consectetur metus orci vitae purus. Sed dui neque, luctus a efficitur sit amet, tempus euismod tortor. In efficitur tincidunt risus sit amet condimentum. Ut consectetur, elit eu consectetur tempor, purus tellus dapibus mi, quis euismod odio nulla eget dolor. Etiam efficitur odio sapien, in maximus nisi rhoncus sit amet. Pellentesque sit amet nulla egestas, egestas magna non, dictum nunc. Integer interdum turpis vel nulla feugiat, in rutrum nulla lobortis. Ut ornare, augue ut posuere lacinia, odio nibh ultricies libero, eu pulvinar est justo et est. Aenean vel tincidunt erat.</p>	2019-02-04 02:48:35.208589+00	2020-07-20 03:06:17.515862+00
2	Lorem Ipsum	Lorem-ipsum	<h1 class="main-title">Lorem Ipsum</h1>	no sum	<hr class="hr-text" />\r\n<h3><strong>At diam massa</strong></h3>\r\n\r\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur sit amet sagittis odio. Sed porta metus vel eros maximus, vitae bibendum magna semper. Nunc id urna erat. Fusce volutpat in tellus suscipit aliquam. Quisque ac enim sit amet felis finibus malesuada. Ut at diam massa. Aliquam erat volutpat. Maecenas ut ipsum libero. Fusce ac lectus nec enim pretium placerat. Aenean ac porta facilisis, nec venenatis augue. Maecenas mollis porta eleifend. Praesent sollicitudin lorem mi, a finibus nisi varius eu. Mauris finibus non neque non viverra. Morbi malesuada, ac et tempus euismod, tortor neque mattis eros, nec malesuada&nbsp;enim vitae elit. Mauris ac facilisis nulla. Sed id mattis urna.</p>\r\n<br />\r\n<img alt="" class="img-centered" src="/philo-b/media/ckuploads/2019/02/04/pexels-photo-917594.jpeg" />\r\n<div class="img-text">Eget mi sed pellentesque</div>\r\n\r\n<h3><strong>Donec sagittis velit</strong></h3>\r\n\r\n<p>Pellentesque porta ut eros ut pulvinar. Suspendisse erat massa, placerat a velit ac, maximus ornare orci. Donec consectetur euismod erat, sit amet lacinia eros congue sit amet. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Etiam ullamcorper tempus tortor a gravida. Etiam tincidunt, risus id pretium ultricies, est dolor luctus nisi, et efficitur nibh libero imperdiet tortor. Integer mollis accumsan facilisis. Sed rutrum leo ac erat ultrices gravida. Phasellus sollicitudin, nisl a efficitur blandit, purus enim sagittis mi, vel fermentum tellus ante eget justo. Pellentesque ligula purus, ornare a dui in, interdum sodales ante. Donec sagittis velit dolor. Pellentesque at augue commodo, ultrices risus molestie, accumsan nisl. Nullam sit amet nisi egestas, venenatis quam in, egestas ligula. Praesent finibus justo nec lorem tincidunt lobortis. Mauris purus urna, fringilla fringilla ex tristique, tincidunt cursus magna. Nullam ornare diam eget lobortis semper.</p>\r\n<br />\r\n<img alt="" class="img-centered" src="/philo-b/media/ckuploads/2019/02/04/red-shade-lamp-perspective-691510.jpeg" />\r\n<div class="img-text">Ut ipsum libero</div>\r\n\r\n<h3><strong>Nunc ut lobortis risus</strong></h3>\r\n\r\n<p>Proin ac ex aliquet lectus venenatis porttitor. Donec vel justo luctus, tristique justo quis, varius purus. Suspendisse vehicula eget mi sed pellentesque. Aliquam sit amet lobortis neque, sed eleifend eros. Nunc ut lobortis risus. Donec pulvinar vel mauris eu sodales. Nulla facilisi. Proin suscipit purus id maximus ornare. Aenean elementum augue diam. Curabitur volutpat cursus tellus, eu rutrum nibh lacinia ac. Suspendisse tempor dolor eu risus varius molestie. In hac habitasse platea dictumst.</p>	2019-02-04 01:08:47.375777+00	2020-07-20 03:03:59.552009+00
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: person
--

COPY public.comments (id, path, cluster, content, pub_date, is_first, is_last, author_id_id, post_id_id, edited) FROM stdin;
2	{2}	2	Fusce purus nulla, semper ac egestas ac, vestibulum eget tortor. Maecenas magna nunc, molestie non libero et, tincidunt efficitur arcu. Nullam pellentesque nunc neque, a consequat felis dapibus bibendum. Ut ultricies risus sit amet est ultricies, ac vestibulum dolor blandit. Sed nec lorem suscipit, pretium turpis nec, tempor mi. Suspendisse quis varius sapien, sit amet aliquet ante. Quisque tincidunt est quis gravida dictum. Fusce volutpat eu quam et tempor. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.	2019-02-04 01:52:03.821951+00	t	t	1	2	2019-02-05 14:31:27.313778+00
9	{9}	3	Primis in faucibus orci luctus et ultrices posuere cubilia Curae.	2019-02-05 14:40:43.482142+00	t	f	6	2	2019-02-05 14:43:55.926567+00
11	{9,11}	3	Donec consectetur euismod erat.	2019-02-05 14:43:55.923021+00	f	t	1	2	2019-02-05 14:43:55.92756+00
10	{10}	4	Faucibus a mi et, luctus venenatis mi.	2019-02-05 14:41:32.395021+00	t	f	6	3	2019-02-05 14:45:33.125688+00
12	{10,12}	4	Eleifend orci sed interdum.	2019-02-05 14:45:33.121999+00	f	f	1	3	2019-02-06 04:12:19.127438+00
21	{10,12,21}	4	Curabitur non arcu.	2019-02-06 04:12:19.123813+00	f	t	6	3	2019-02-06 04:12:19.128431+00
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: person
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2019-02-03 15:59:36.623483+00	1	Blog object (1)	1	[{"added": {}}]	13	1
2	2019-02-03 17:38:52.447444+00	1	example.com	3		5	1
3	2019-02-03 18:06:42.62833+00	2	first-user	3		12	1
4	2019-02-03 18:29:04.270347+00	3	user-one	3		12	1
5	2019-02-03 18:31:12.044909+00	2	www.philo-b.xyz	2	[{"changed": {"fields": ["domain"]}}]	5	1
6	2019-02-03 18:34:06.653176+00	4	user-one	3		12	1
7	2019-02-03 18:45:42.53551+00	5	user-one	3		12	1
8	2019-02-04 01:08:47.377882+00	2	Blog object (2)	1	[{"added": {}}]	13	1
9	2019-02-04 01:11:15.747608+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
10	2019-02-04 01:13:05.781539+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
11	2019-02-04 01:13:39.670684+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
12	2019-02-04 01:14:31.455167+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
13	2019-02-04 01:15:49.573836+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
14	2019-02-04 01:18:31.819493+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
15	2019-02-04 01:23:13.632179+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
16	2019-02-04 01:29:27.227581+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
17	2019-02-04 01:30:20.457764+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
18	2019-02-04 01:30:57.783317+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
19	2019-02-04 01:38:17.320508+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
20	2019-02-04 01:41:02.584048+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
21	2019-02-04 01:41:22.062834+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
22	2019-02-04 01:41:49.100609+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
23	2019-02-04 01:42:08.4526+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
24	2019-02-04 01:42:10.717143+00	2	Blog object (2)	2	[]	13	1
25	2019-02-04 01:42:46.483407+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
26	2019-02-04 01:43:06.025371+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
27	2019-02-04 01:43:40.343283+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
28	2019-02-04 01:44:05.911546+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
29	2019-02-04 01:44:51.355259+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
30	2019-02-04 01:47:34.542898+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
31	2019-02-04 01:48:06.718453+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
32	2019-02-04 01:48:58.29901+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
33	2019-02-04 01:50:14.278795+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
34	2019-02-04 01:50:43.533618+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
35	2019-02-04 01:51:17.585542+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
36	2019-02-04 01:52:56.033468+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
37	2019-02-04 02:02:23.141396+00	3	Blog object (3)	1	[{"added": {}}]	13	1
38	2019-02-04 02:03:08.991655+00	3	Blog object (3)	2	[{"changed": {"fields": ["content"]}}]	13	1
39	2019-02-04 02:05:09.852093+00	3	Blog object (3)	2	[{"changed": {"fields": ["content"]}}]	13	1
40	2019-02-04 02:05:42.578289+00	3	Blog object (3)	2	[{"changed": {"fields": ["content"]}}]	13	1
41	2019-02-04 02:05:58.904529+00	3	Blog object (3)	2	[{"changed": {"fields": ["content"]}}]	13	1
42	2019-02-04 02:06:12.620688+00	3	Blog object (3)	2	[{"changed": {"fields": ["content"]}}]	13	1
43	2019-02-04 02:06:45.53235+00	3	Blog object (3)	2	[{"changed": {"fields": ["content"]}}]	13	1
44	2019-02-04 02:07:22.54591+00	3	Blog object (3)	2	[{"changed": {"fields": ["content"]}}]	13	1
45	2019-02-04 02:09:45.535985+00	3	Blog object (3)	2	[{"changed": {"fields": ["content"]}}]	13	1
46	2019-02-04 02:10:32.772342+00	3	Blog object (3)	2	[{"changed": {"fields": ["content"]}}]	13	1
47	2019-02-04 02:11:04.273366+00	3	Blog object (3)	2	[{"changed": {"fields": ["content"]}}]	13	1
48	2019-02-04 02:13:25.704412+00	3	Blog object (3)	2	[{"changed": {"fields": ["content"]}}]	13	1
49	2019-02-04 02:14:03.980864+00	3	Blog object (3)	2	[{"changed": {"fields": ["content"]}}]	13	1
50	2019-02-04 02:14:52.565269+00	3	Blog object (3)	2	[{"changed": {"fields": ["content"]}}]	13	1
51	2019-02-04 02:15:52.654487+00	3	Blog object (3)	2	[{"changed": {"fields": ["content"]}}]	13	1
52	2019-02-04 02:17:48.06656+00	3	Blog object (3)	2	[{"changed": {"fields": ["content"]}}]	13	1
53	2019-02-04 02:20:51.321072+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
54	2019-02-04 02:23:58.004117+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
55	2019-02-04 02:25:01.745384+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
56	2019-02-04 02:25:28.772097+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
57	2019-02-04 02:25:46.748357+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
58	2019-02-04 02:26:27.352227+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
59	2019-02-04 02:27:06.542725+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
60	2019-02-04 02:44:07.623296+00	4	Blog object (4)	1	[{"added": {}}]	13	1
61	2019-02-04 02:45:59.861101+00	4	Blog object (4)	3		13	1
62	2019-02-04 02:48:35.210494+00	5	Blog object (5)	1	[{"added": {}}]	13	1
63	2019-02-04 03:24:39.010656+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
64	2019-02-04 03:25:32.279402+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
65	2019-02-04 03:26:13.489415+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
66	2019-02-04 03:26:54.370222+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
67	2019-02-04 03:28:25.150528+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
68	2019-02-04 03:35:10.194352+00	5	Blog object (5)	2	[{"changed": {"fields": ["short_title", "slug", "title", "summary", "content"]}}]	13	1
69	2019-02-04 03:36:26.403011+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
70	2019-02-04 03:38:25.110409+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
71	2019-02-04 03:39:24.024487+00	5	Blog object (5)	2	[]	13	1
72	2019-02-04 03:39:53.212808+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
73	2019-02-04 03:46:11.614804+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
74	2019-02-04 03:49:06.089505+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
75	2019-02-04 03:49:28.783134+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
76	2019-02-04 03:51:06.545035+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
77	2019-02-04 03:51:44.043507+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
78	2019-02-04 03:52:30.187275+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
79	2019-02-04 03:53:14.774981+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
80	2019-02-04 03:53:46.443272+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
81	2019-02-04 03:55:17.242811+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
82	2019-02-04 03:57:09.684444+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
83	2019-02-05 04:17:16.161433+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
84	2019-02-05 14:35:19.64305+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
85	2019-02-05 14:35:54.710944+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
86	2019-02-05 14:37:29.355311+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
87	2019-02-05 14:37:46.539736+00	1	Blog object (1)	3		13	1
88	2019-02-06 02:57:53.199327+00	13	Interdum turpis vel nulla	3		14	1
89	2019-02-06 02:58:45.915183+00	14	interdum turpis vel nulla	3		14	1
90	2019-02-06 02:59:42.967874+00	15	interdum turpis vel nulla	3		14	1
91	2019-02-06 03:00:54.320371+00	16	Etiam efficitur odio sapien	3		14	1
92	2019-02-06 03:02:32.408055+00	17	Etiam efficitur odio sapien	3		14	1
93	2019-02-06 03:03:36.838556+00	19	sdfsdf	3		14	1
94	2019-02-06 03:03:36.839795+00	18	Etiam efficitur odio sapien	3		14	1
95	2019-02-06 03:06:38.18602+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
96	2019-02-06 04:02:02.001864+00	20	asdfsdfa	3		14	1
97	2019-02-08 02:40:01.303041+00	5	Blog object (5)	2	[{"changed": {"fields": ["short_title", "title", "content"]}}]	13	1
98	2019-02-08 02:40:46.608117+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
99	2019-02-08 02:43:46.633558+00	5	Blog object (5)	2	[{"changed": {"fields": ["title"]}}]	13	1
100	2019-02-08 02:44:38.629858+00	5	Blog object (5)	2	[{"changed": {"fields": ["title"]}}]	13	1
101	2019-02-08 02:45:10.077852+00	5	Blog object (5)	2	[{"changed": {"fields": ["title"]}}]	13	1
102	2019-02-08 02:50:16.0169+00	5	Blog object (5)	2	[{"changed": {"fields": ["title"]}}]	13	1
103	2019-02-08 02:53:27.579878+00	5	Blog object (5)	2	[]	13	1
104	2019-02-08 02:54:40.924979+00	3	Blog object (3)	2	[{"changed": {"fields": ["title", "content"]}}]	13	1
105	2019-02-08 03:01:25.474218+00	2	Blog object (2)	2	[{"changed": {"fields": ["title"]}}]	13	1
106	2019-02-08 03:01:57.208617+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
107	2019-02-08 03:12:16.613333+00	6	Blog object (6)	1	[{"added": {}}]	13	1
108	2019-02-08 03:15:08.212878+00	6	Blog object (6)	3		13	1
109	2019-02-08 03:24:30.840626+00	2	Blog object (2)	2	[{"changed": {"fields": ["short_title", "title"]}}]	13	1
110	2019-02-09 02:52:59.487062+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
111	2019-02-09 02:59:33.781255+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
112	2019-02-09 03:02:06.430122+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
113	2019-02-09 03:04:24.804174+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
114	2019-02-09 03:05:02.189666+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
115	2019-02-09 03:06:43.585414+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
116	2019-02-09 03:07:52.078693+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
117	2019-02-09 03:08:49.638551+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
118	2019-02-09 03:14:32.483991+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
119	2019-02-09 03:15:13.379949+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
120	2019-02-09 03:15:43.139082+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
121	2019-02-09 03:15:56.248678+00	5	Blog object (5)	2	[{"changed": {"fields": ["summary", "content"]}}]	13	1
122	2019-02-09 03:15:56.656753+00	5	Blog object (5)	2	[]	13	1
123	2019-02-09 03:22:35.647218+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
124	2019-02-09 03:23:02.878051+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
125	2019-02-09 03:24:03.627711+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
126	2019-02-09 03:24:39.333276+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
127	2019-02-09 03:25:21.384726+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
128	2019-02-09 03:26:13.781117+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
129	2019-02-09 03:26:50.702473+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
130	2019-02-09 03:29:17.03896+00	3	Blog object (3)	2	[{"changed": {"fields": ["content"]}}]	13	1
131	2019-02-09 03:30:27.05329+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
132	2019-02-09 03:38:17.417918+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
133	2019-02-09 03:39:30.452039+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
134	2019-02-09 03:39:54.879625+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
135	2019-02-09 03:40:22.824836+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
136	2019-02-09 03:41:12.316013+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	1
137	2019-02-09 03:42:32.185944+00	3	Blog object (3)	2	[{"changed": {"fields": ["content"]}}]	13	1
138	2019-02-09 03:42:56.676401+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	1
139	2019-02-24 01:29:03.784013+00	28	asdfads	3		14	1
140	2019-02-24 01:29:03.786889+00	27	safsd	3		14	1
141	2019-02-24 01:29:03.787565+00	26	sdddfasdf	3		14	1
142	2019-02-24 01:29:03.788169+00	25	asdfsadf	3		14	1
143	2019-02-24 01:29:03.788782+00	24	sadfsadf	3		14	1
144	2019-02-24 01:29:03.789387+00	23	sdfsdf	3		14	1
145	2019-02-24 01:29:03.789984+00	22	skjlahflkdshlkdsafadhlfks	3		14	1
146	2019-02-24 01:30:10.98072+00	30	sdfsd	3		14	1
147	2019-02-24 01:30:10.981911+00	29	sdfds	3		14	1
148	2019-02-24 01:35:50.961079+00	37	sdf	3		14	1
149	2019-02-24 01:35:50.962294+00	36	sadf	3		14	1
150	2019-02-24 01:35:50.962916+00	35	sdafadsf	3		14	1
151	2019-02-24 01:35:50.963619+00	34	dsdaf	3		14	1
152	2019-02-24 01:35:50.964224+00	33	sddf	3		14	1
153	2019-02-24 01:35:50.964829+00	32	sdfds	3		14	1
154	2019-02-24 01:35:50.965423+00	31	sdafasd	3		14	1
155	2020-07-20 02:59:19.932456+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	7
156	2020-07-20 03:00:34.042413+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	7
157	2020-07-20 03:01:54.489293+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	7
158	2020-07-20 03:03:12.295374+00	3	Blog object (3)	2	[{"changed": {"fields": ["content"]}}]	13	7
159	2020-07-20 03:03:59.558218+00	2	Blog object (2)	2	[{"changed": {"fields": ["content"]}}]	13	7
160	2020-07-20 03:06:17.518623+00	5	Blog object (5)	2	[{"changed": {"fields": ["content"]}}]	13	7
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: person
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	auth	permission
2	auth	group
3	contenttypes	contenttype
4	sessions	session
5	sites	site
6	admin	logentry
7	account	emailconfirmation
8	account	emailaddress
9	socialaccount	socialaccount
10	socialaccount	socialapp
11	socialaccount	socialtoken
12	users	customuser
13	blog	blog
14	blog	comment
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: person
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2019-02-03 15:37:21.631712+00
2	contenttypes	0002_remove_content_type_name	2019-02-03 15:37:21.648952+00
3	auth	0001_initial	2019-02-03 15:37:21.685616+00
4	auth	0002_alter_permission_name_max_length	2019-02-03 15:37:21.695506+00
5	auth	0003_alter_user_email_max_length	2019-02-03 15:37:21.703816+00
6	auth	0004_alter_user_username_opts	2019-02-03 15:37:21.712052+00
7	auth	0005_alter_user_last_login_null	2019-02-03 15:37:21.722404+00
8	auth	0006_require_contenttypes_0002	2019-02-03 15:37:21.724752+00
9	auth	0007_alter_validators_add_error_messages	2019-02-03 15:37:21.732792+00
10	auth	0008_alter_user_username_max_length	2019-02-03 15:37:21.740717+00
11	auth	0009_alter_user_last_name_max_length	2019-02-03 15:37:21.748794+00
12	users	0001_initial	2019-02-03 15:37:21.786384+00
13	account	0001_initial	2019-02-03 15:37:21.825435+00
14	account	0002_email_max_length	2019-02-03 15:37:21.84087+00
15	admin	0001_initial	2019-02-03 15:37:21.870452+00
16	admin	0002_logentry_remove_auto_add	2019-02-03 15:37:21.884998+00
17	sessions	0001_initial	2019-02-03 15:37:21.896257+00
18	sites	0001_initial	2019-02-03 15:37:21.906182+00
19	sites	0002_alter_domain_unique	2019-02-03 15:37:21.914217+00
20	socialaccount	0001_initial	2019-02-03 15:37:22.000818+00
21	socialaccount	0002_token_max_lengths	2019-02-03 15:37:22.035077+00
22	socialaccount	0003_extra_data_default_dict	2019-02-03 15:37:22.048948+00
23	blog	0001_initial	2019-02-03 15:56:34.514575+00
24	blog	0002_auto_20190205_1431	2019-02-05 14:31:27.339609+00
25	blog	0003_auto_20190205_1434	2019-02-05 14:34:43.496949+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: person
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
xrf56u2xks29uesu878ssxro6z3kw5m4	MzExYmEzOGNkOWQwNWQ2Yjk0N2MzNGE5Y2RkMjFiNDhmMjg5MWEwYzp7Il9zZXNzaW9uX2V4cGlyeSI6MCwiYWNjb3VudF91c2VyIjoiNiIsImFjY291bnRfdmVyaWZpZWRfZW1haWwiOm51bGx9	2019-02-17 18:53:30.633458+00
cjxn8ofr2o37kqo1czarbcb1obqpwxu6	ZGRlNTI4ZTQ0OGU0NDY5MWY1OGE2NjkyMWI1ZjQ3OGVkOThjZDhkMzp7Il9zZXNzaW9uX2V4cGlyeSI6MCwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2hhc2giOiJiZGM2YjliODZmYWQxMDRiMzljNzhlYTY5MzlkZDIxODllZDA1YzcxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQifQ==	2019-02-18 00:33:20.29974+00
56tv691zgx0i0k8uaoq370fvbzsq7prk	ZTgzNGEyNmRmOTkyZDExOGFmOWQzNzFkZmIyMmNjYjI0NTFlZWRmMTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfc2Vzc2lvbl9leHBpcnkiOjAsIl9hdXRoX3VzZXJfaGFzaCI6ImJkYzZiOWI4NmZhZDEwNGIzOWM3OGVhNjkzOWRkMjE4OWVkMDVjNzEifQ==	2019-02-19 04:26:50.543847+00
f6rdwd408wrmju8uz3yjjgnlqikgcaps	MDEyMzkxNGNiZmI4ZjcxZjA2NGRlYWU5OGE2ZTRmYTM1MTAxNmQ2Njp7Il9hdXRoX3VzZXJfaWQiOiI2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfc2Vzc2lvbl9leHBpcnkiOjAsIl9hdXRoX3VzZXJfaGFzaCI6ImNiOTNlNjg2ZWJlNTAyNzdiN2JiNzE0Yzg2NGJiMzJjYjY4ZDZkMzQifQ==	2019-02-20 02:52:41.927313+00
cvxpmpfvsp6xdh7ps2sr3pl1g3bggud7	Y2I3YTNhNzNmNjVjOTFkNWRkYzdiMDJiMmQ4MWRiMjc5ZDAxZmQxZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiZGM2YjliODZmYWQxMDRiMzljNzhlYTY5MzlkZDIxODllZDA1YzcxIn0=	2019-02-20 02:57:34.996712+00
49jt183sswgt1j0ebz7rgk7q0p5zd98p	MzhhMzA2ZjkwYjlkMTBmNWQ4MWFkMzUzMzZjMDcxYWU2YjY5YzJjYzp7Il9hdXRoX3VzZXJfaGFzaCI6ImJkYzZiOWI4NmZhZDEwNGIzOWM3OGVhNjkzOWRkMjE4OWVkMDVjNzEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2019-03-10 01:28:33.543043+00
p22izunpbjxvnn5xust1u73flcta6k21	MzMzMjI5YWZhNmY0ZTk2OTNlYjhhMGRhOWMwYzZiNDc5ZGU4OTY4NDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJkYzZiOWI4NmZhZDEwNGIzOWM3OGVhNjkzOWRkMjE4OWVkMDVjNzEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9zZXNzaW9uX2V4cGlyeSI6MCwiX2F1dGhfdXNlcl9pZCI6IjEifQ==	2019-04-10 14:35:30.292125+00
htt42e7qzuvr5lotei3sbbwntay203s8	Nzc5N2YyZTU4Yjc5OThjMDFjOTRhMTNkNzY3MDVkMmNhM2MxMmE3Yjp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9oYXNoIjoiODc2ZjllNzkwNTcyZDYxN2IxMjE1MGU5ZWRlZmFhZGUyZTQyY2QwMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2020-08-03 02:54:38.045049+00
nwh7wgoy2ewhxn4dls4ez3hylen7zxac	Nzc5N2YyZTU4Yjc5OThjMDFjOTRhMTNkNzY3MDVkMmNhM2MxMmE3Yjp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9oYXNoIjoiODc2ZjllNzkwNTcyZDYxN2IxMjE1MGU5ZWRlZmFhZGUyZTQyY2QwMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2020-08-03 02:54:55.308084+00
tz5rlnqk377mhnfepx8glwgac43wrtol	Nzc5N2YyZTU4Yjc5OThjMDFjOTRhMTNkNzY3MDVkMmNhM2MxMmE3Yjp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9oYXNoIjoiODc2ZjllNzkwNTcyZDYxN2IxMjE1MGU5ZWRlZmFhZGUyZTQyY2QwMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2020-08-03 02:55:14.023616+00
lihzly78hqwb3rveas54x13ctl51j1uh	Nzc5N2YyZTU4Yjc5OThjMDFjOTRhMTNkNzY3MDVkMmNhM2MxMmE3Yjp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9oYXNoIjoiODc2ZjllNzkwNTcyZDYxN2IxMjE1MGU5ZWRlZmFhZGUyZTQyY2QwMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2020-08-03 02:55:48.36966+00
kem0euvhygyxacrkdqmk6zlaxfful60i	Nzc5N2YyZTU4Yjc5OThjMDFjOTRhMTNkNzY3MDVkMmNhM2MxMmE3Yjp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9oYXNoIjoiODc2ZjllNzkwNTcyZDYxN2IxMjE1MGU5ZWRlZmFhZGUyZTQyY2QwMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2020-08-03 02:57:55.307075+00
5evi9oiig8qxssnzt9glm253c9bzswbu	Nzc5N2YyZTU4Yjc5OThjMDFjOTRhMTNkNzY3MDVkMmNhM2MxMmE3Yjp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9oYXNoIjoiODc2ZjllNzkwNTcyZDYxN2IxMjE1MGU5ZWRlZmFhZGUyZTQyY2QwMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2020-08-03 03:13:41.47838+00
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: person
--

COPY public.django_site (id, domain, name) FROM stdin;
2	www.philo-b.xyz	philo-b
\.


--
-- Data for Name: socialaccount_socialaccount; Type: TABLE DATA; Schema: public; Owner: person
--

COPY public.socialaccount_socialaccount (id, provider, uid, last_login, date_joined, extra_data, user_id) FROM stdin;
\.


--
-- Data for Name: socialaccount_socialapp; Type: TABLE DATA; Schema: public; Owner: person
--

COPY public.socialaccount_socialapp (id, provider, name, client_id, secret, key) FROM stdin;
\.


--
-- Data for Name: socialaccount_socialapp_sites; Type: TABLE DATA; Schema: public; Owner: person
--

COPY public.socialaccount_socialapp_sites (id, socialapp_id, site_id) FROM stdin;
\.


--
-- Data for Name: socialaccount_socialtoken; Type: TABLE DATA; Schema: public; Owner: person
--

COPY public.socialaccount_socialtoken (id, token, token_secret, expires_at, account_id, app_id) FROM stdin;
\.


--
-- Data for Name: users_customuser; Type: TABLE DATA; Schema: public; Owner: person
--

COPY public.users_customuser (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
6	argon2$argon2i$v=19$m=512,t=2,p=2$RkJjOHdOclRJWkg2$eOcvytlOK4qe1U+75tA8rQ	2019-02-24 01:15:26.965417+00	f	user-two			denniszethof@gmail.com	f	t	2019-02-03 18:46:14.773412+00
1	argon2$argon2i$v=19$m=512,t=2,p=2$RE1yelhSQW51R3V6$hD7NfcQYDeybYmKvGUC+/A	2019-03-27 14:35:30.288549+00	t	ola			mmmmmmm@gmail.com	t	t	2019-02-03 15:40:21.147598+00
7	argon2$argon2i$v=19$m=512,t=2,p=2$QWt4ZDg1VjI4N3F3$qwk6o4c7fjXudizd/f9MLw	2020-07-20 03:13:41.474654+00	t	meme			meme@example.com	t	t	2020-07-20 02:45:07.341251+00
\.


--
-- Data for Name: users_customuser_groups; Type: TABLE DATA; Schema: public; Owner: person
--

COPY public.users_customuser_groups (id, customuser_id, group_id) FROM stdin;
\.


--
-- Data for Name: users_customuser_user_permissions; Type: TABLE DATA; Schema: public; Owner: person
--

COPY public.users_customuser_user_permissions (id, customuser_id, permission_id) FROM stdin;
\.


--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: person
--

SELECT pg_catalog.setval('public.account_emailaddress_id_seq', 7, true);


--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: person
--

SELECT pg_catalog.setval('public.account_emailconfirmation_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: person
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: person
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: person
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 42, true);


--
-- Name: blog_blog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: person
--

SELECT pg_catalog.setval('public.blog_blog_id_seq', 6, true);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: person
--

SELECT pg_catalog.setval('public.comments_id_seq', 37, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: person
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 160, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: person
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 14, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: person
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 25, true);


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: person
--

SELECT pg_catalog.setval('public.django_site_id_seq', 2, true);


--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: person
--

SELECT pg_catalog.setval('public.socialaccount_socialaccount_id_seq', 1, false);


--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: person
--

SELECT pg_catalog.setval('public.socialaccount_socialapp_id_seq', 1, false);


--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: person
--

SELECT pg_catalog.setval('public.socialaccount_socialapp_sites_id_seq', 1, false);


--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: person
--

SELECT pg_catalog.setval('public.socialaccount_socialtoken_id_seq', 1, false);


--
-- Name: users_customuser_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: person
--

SELECT pg_catalog.setval('public.users_customuser_groups_id_seq', 1, false);


--
-- Name: users_customuser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: person
--

SELECT pg_catalog.setval('public.users_customuser_id_seq', 8, true);


--
-- Name: users_customuser_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: person
--

SELECT pg_catalog.setval('public.users_customuser_user_permissions_id_seq', 1, false);


--
-- Name: account_emailaddress account_emailaddress_email_key; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_email_key UNIQUE (email);


--
-- Name: account_emailaddress account_emailaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_pkey PRIMARY KEY (id);


--
-- Name: account_emailconfirmation account_emailconfirmation_key_key; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_key_key UNIQUE (key);


--
-- Name: account_emailconfirmation account_emailconfirmation_pkey; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: blog_blog blog_blog_pkey; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.blog_blog
    ADD CONSTRAINT blog_blog_pkey PRIMARY KEY (id);


--
-- Name: blog_blog blog_blog_short_title_key; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.blog_blog
    ADD CONSTRAINT blog_blog_short_title_key UNIQUE (short_title);


--
-- Name: blog_blog blog_blog_slug_key; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.blog_blog
    ADD CONSTRAINT blog_blog_slug_key UNIQUE (slug);


--
-- Name: blog_blog blog_blog_title_key; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.blog_blog
    ADD CONSTRAINT blog_blog_title_key UNIQUE (title);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount socialaccount_socialaccount_pkey; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount socialaccount_socialaccount_provider_uid_fc810c6e_uniq; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_provider_uid_fc810c6e_uniq UNIQUE (provider, uid);


--
-- Name: socialaccount_socialapp_sites socialaccount_socialapp__socialapp_id_site_id_71a9a768_uniq; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp__socialapp_id_site_id_71a9a768_uniq UNIQUE (socialapp_id, site_id);


--
-- Name: socialaccount_socialapp socialaccount_socialapp_pkey; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.socialaccount_socialapp
    ADD CONSTRAINT socialaccount_socialapp_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialapp_sites socialaccount_socialapp_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_sites_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialtoken socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq UNIQUE (app_id, account_id);


--
-- Name: socialaccount_socialtoken socialaccount_socialtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_pkey PRIMARY KEY (id);


--
-- Name: users_customuser_groups users_customuser_groups_customuser_id_group_id_76b619e3_uniq; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.users_customuser_groups
    ADD CONSTRAINT users_customuser_groups_customuser_id_group_id_76b619e3_uniq UNIQUE (customuser_id, group_id);


--
-- Name: users_customuser_groups users_customuser_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.users_customuser_groups
    ADD CONSTRAINT users_customuser_groups_pkey PRIMARY KEY (id);


--
-- Name: users_customuser users_customuser_pkey; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.users_customuser
    ADD CONSTRAINT users_customuser_pkey PRIMARY KEY (id);


--
-- Name: users_customuser_user_permissions users_customuser_user_pe_customuser_id_permission_7a7debf6_uniq; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.users_customuser_user_permissions
    ADD CONSTRAINT users_customuser_user_pe_customuser_id_permission_7a7debf6_uniq UNIQUE (customuser_id, permission_id);


--
-- Name: users_customuser_user_permissions users_customuser_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.users_customuser_user_permissions
    ADD CONSTRAINT users_customuser_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: users_customuser users_customuser_username_key; Type: CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.users_customuser
    ADD CONSTRAINT users_customuser_username_key UNIQUE (username);


--
-- Name: account_emailaddress_email_03be32b2_like; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX account_emailaddress_email_03be32b2_like ON public.account_emailaddress USING btree (email varchar_pattern_ops);


--
-- Name: account_emailaddress_user_id_2c513194; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX account_emailaddress_user_id_2c513194 ON public.account_emailaddress USING btree (user_id);


--
-- Name: account_emailconfirmation_email_address_id_5b7f8c58; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX account_emailconfirmation_email_address_id_5b7f8c58 ON public.account_emailconfirmation USING btree (email_address_id);


--
-- Name: account_emailconfirmation_key_f43612bd_like; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX account_emailconfirmation_key_f43612bd_like ON public.account_emailconfirmation USING btree (key varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: blog_blog_posted_869d36eb; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX blog_blog_posted_869d36eb ON public.blog_blog USING btree (posted);


--
-- Name: blog_blog_short_title_82084021_like; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX blog_blog_short_title_82084021_like ON public.blog_blog USING btree (short_title varchar_pattern_ops);


--
-- Name: blog_blog_slug_4812aa2c_like; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX blog_blog_slug_4812aa2c_like ON public.blog_blog USING btree (slug varchar_pattern_ops);


--
-- Name: blog_blog_title_942d8a1e_like; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX blog_blog_title_942d8a1e_like ON public.blog_blog USING btree (title varchar_pattern_ops);


--
-- Name: comments_author_id_id_d85a8674; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX comments_author_id_id_d85a8674 ON public.comments USING btree (author_id_id);


--
-- Name: comments_post_id_id_bc1cd48b; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX comments_post_id_id_bc1cd48b ON public.comments USING btree (post_id_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX django_site_domain_a2e37b91_like ON public.django_site USING btree (domain varchar_pattern_ops);


--
-- Name: socialaccount_socialaccount_user_id_8146e70c; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX socialaccount_socialaccount_user_id_8146e70c ON public.socialaccount_socialaccount USING btree (user_id);


--
-- Name: socialaccount_socialapp_sites_site_id_2579dee5; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX socialaccount_socialapp_sites_site_id_2579dee5 ON public.socialaccount_socialapp_sites USING btree (site_id);


--
-- Name: socialaccount_socialapp_sites_socialapp_id_97fb6e7d; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX socialaccount_socialapp_sites_socialapp_id_97fb6e7d ON public.socialaccount_socialapp_sites USING btree (socialapp_id);


--
-- Name: socialaccount_socialtoken_account_id_951f210e; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX socialaccount_socialtoken_account_id_951f210e ON public.socialaccount_socialtoken USING btree (account_id);


--
-- Name: socialaccount_socialtoken_app_id_636a42d7; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX socialaccount_socialtoken_app_id_636a42d7 ON public.socialaccount_socialtoken USING btree (app_id);


--
-- Name: users_customuser_groups_customuser_id_958147bf; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX users_customuser_groups_customuser_id_958147bf ON public.users_customuser_groups USING btree (customuser_id);


--
-- Name: users_customuser_groups_group_id_01390b14; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX users_customuser_groups_group_id_01390b14 ON public.users_customuser_groups USING btree (group_id);


--
-- Name: users_customuser_user_permissions_customuser_id_5771478b; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX users_customuser_user_permissions_customuser_id_5771478b ON public.users_customuser_user_permissions USING btree (customuser_id);


--
-- Name: users_customuser_user_permissions_permission_id_baaa2f74; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX users_customuser_user_permissions_permission_id_baaa2f74 ON public.users_customuser_user_permissions USING btree (permission_id);


--
-- Name: users_customuser_username_80452fdf_like; Type: INDEX; Schema: public; Owner: person
--

CREATE INDEX users_customuser_username_80452fdf_like ON public.users_customuser USING btree (username varchar_pattern_ops);


--
-- Name: account_emailaddress account_emailaddress_user_id_2c513194_fk_users_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_user_id_2c513194_fk_users_customuser_id FOREIGN KEY (user_id) REFERENCES public.users_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_emailconfirmation account_emailconfirm_email_address_id_5b7f8c58_fk_account_e; Type: FK CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirm_email_address_id_5b7f8c58_fk_account_e FOREIGN KEY (email_address_id) REFERENCES public.account_emailaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: comments comments_author_id_id_d85a8674_fk_users_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_author_id_id_d85a8674_fk_users_customuser_id FOREIGN KEY (author_id_id) REFERENCES public.users_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: comments comments_post_id_id_bc1cd48b_fk_blog_blog_id; Type: FK CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_post_id_id_bc1cd48b_fk_blog_blog_id FOREIGN KEY (post_id_id) REFERENCES public.blog_blog(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_users_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_users_customuser_id FOREIGN KEY (user_id) REFERENCES public.users_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialtoken socialaccount_social_account_id_951f210e_fk_socialacc; Type: FK CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_social_account_id_951f210e_fk_socialacc FOREIGN KEY (account_id) REFERENCES public.socialaccount_socialaccount(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialtoken socialaccount_social_app_id_636a42d7_fk_socialacc; Type: FK CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_social_app_id_636a42d7_fk_socialacc FOREIGN KEY (app_id) REFERENCES public.socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialapp_sites socialaccount_social_site_id_2579dee5_fk_django_si; Type: FK CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_social_site_id_2579dee5_fk_django_si FOREIGN KEY (site_id) REFERENCES public.django_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialapp_sites socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc; Type: FK CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc FOREIGN KEY (socialapp_id) REFERENCES public.socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialaccount socialaccount_social_user_id_8146e70c_fk_users_cus; Type: FK CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_social_user_id_8146e70c_fk_users_cus FOREIGN KEY (user_id) REFERENCES public.users_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_customuser_groups users_customuser_gro_customuser_id_958147bf_fk_users_cus; Type: FK CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.users_customuser_groups
    ADD CONSTRAINT users_customuser_gro_customuser_id_958147bf_fk_users_cus FOREIGN KEY (customuser_id) REFERENCES public.users_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_customuser_groups users_customuser_groups_group_id_01390b14_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.users_customuser_groups
    ADD CONSTRAINT users_customuser_groups_group_id_01390b14_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_customuser_user_permissions users_customuser_use_customuser_id_5771478b_fk_users_cus; Type: FK CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.users_customuser_user_permissions
    ADD CONSTRAINT users_customuser_use_customuser_id_5771478b_fk_users_cus FOREIGN KEY (customuser_id) REFERENCES public.users_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_customuser_user_permissions users_customuser_use_permission_id_baaa2f74_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: person
--

ALTER TABLE ONLY public.users_customuser_user_permissions
    ADD CONSTRAINT users_customuser_use_permission_id_baaa2f74_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.13 (Debian 10.13-1.pgdg90+1)
-- Dumped by pg_dump version 10.13 (Debian 10.13-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.13 (Debian 10.13-1.pgdg90+1)
-- Dumped by pg_dump version 10.13 (Debian 10.13-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

