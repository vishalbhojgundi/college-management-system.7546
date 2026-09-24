# College Management System

A Java web app (Servlets + JSP + JDBC/MySQL, built with Maven) for managing
students, courses and weekly-test marks, with role-based access for
**Admin**, **Staff**, **Parent**, and public visitors.

## Roles

| Role   | Can do |
|--------|--------|
| Public (no login) | View About / Staff / Achievements / Contact on the homepage |
| Parent  | Log in, search a student, view info + weekly-test results (read-only) |
| Staff   | Log in, add/update/delete students, manage weekly-test marks, view courses |
| Admin   | Everything Staff can do, plus manage courses |

## Tech stack

- Java 11, Jakarta Servlet 5.0 / JSP (Tomcat 10+ namespace — **jakarta.***, not javax.*)
- Maven (`pom.xml`)
- MySQL via `mysql-connector-j`
- Plain JSP + JSTL-ready, no frontend framework

> If you're deploying to **Tomcat 9 or earlier** (javax.* namespace), you'll need to
> change all `jakarta.servlet.*` imports back to `javax.servlet.*` and use the
> matching servlet-api version in `pom.xml`.

## Project setup

### 1. Database

You already have `course`, `student`, `weekly_test`, and now `users`
(`user_id`, `username`, `password`, `role`). Insert 3 sample accounts:

```sql
INSERT INTO users (username, password, role) VALUES
('admin',  'admin123',  'ADMIN'),
('staff1', 'staff123',  'STAFF'),
('parent1','parent123', 'PARENT');
```

(Or run the full script, which also creates the table if it doesn't exist:
`mysql -u root -p college_management_system < src/main/resources/schema_users.sql`)

| username | password  | role   |
|----------|-----------|--------|
| admin    | admin123  | ADMIN  |
| staff1   | staff123  | STAFF  |
| parent1  | parent123 | PARENT |

**Note:** Passwords are stored in plain text for simplicity. For anything beyond
local learning/dev, hash passwords (e.g. with BCrypt) before storing/comparing them
in `UserDAO.java`.

### 2. Configure DB credentials

Edit `src/main/java/com/college/util/DBConnection.java` and set your MySQL
username/password if different from `root` / `root`.

### 3. Build and deploy

```bash
mvn clean package
```

This produces `target/college_management_system.war`. Deploy it to Tomcat 10+
(e.g. copy into `webapps/`), then visit:

```
http://localhost:8080/college_management_system/
```

## How the pieces fit together

- `model/` — plain Java objects mapping to `student`, `course`, `weekly_test`, `users`
- `dao/` — JDBC queries (CRUD) for each table, using `DBConnection`
- `controller/` — servlets that handle form submissions and page routing:
  - `LoginServlet` / `LogoutServlet` — authentication, session + role storage
  - `StudentServlet`, `CourseServlet`, `WeeklyTestServlet` — admin/staff CRUD
  - `SearchStudentServlet` — read-only search, used by parents
- `webapp/` — JSP views, split into public, `admin/`, `staff/`, `parent/`

Role checks currently happen inline at the top of each servlet/JSP
(`session.getAttribute("role")`). For a larger app, consider moving this into
a single `Filter` (e.g. `AccessControlFilter`) instead of repeating checks.

## Suggested next steps

- Add server-side validation (currently only basic HTML5 `required` attributes)
- Hash passwords with BCrypt instead of storing them in plain text
- Add pagination to student/test tables once data grows
- Add a "forgot password" flow or admin-managed account creation UI
