---
name: code-review
description: Comprehensive code review for security, performance, and conventions
version: 1.0.0
---

# Code Review Skill

## Purpose
Perform thorough code review covering security, logic, performance, and team conventions.

## When to Use
- Reviewing PRs before merge
- Self-review before submitting PR
- Auditing existing code for issues

## Instructions

When reviewing code, follow this systematic approach:

### 1. Security Analysis (Critical)
Check for these vulnerabilities:
- **Injection**: SQL, NoSQL, command, XSS, LDAP
- **Authentication**: Weak passwords, missing MFA, session issues
- **Authorization**: Missing checks, IDOR, privilege escalation
- **Data Exposure**: Sensitive data in logs, responses, errors
- **Dependencies**: Known vulnerabilities in packages

### 2. Logic Verification
- Does the code do what it claims?
- Are all code paths tested?
- Edge cases: null, empty, boundary values, concurrent access
- Error handling: Are errors caught and handled appropriately?
- State management: Race conditions, stale data

### 3. Performance Assessment
- **Database**: N+1 queries, missing indexes, large result sets
- **Memory**: Leaks, large allocations, unbounded collections
- **Network**: Excessive API calls, missing caching, payload size
- **Algorithms**: Time/space complexity appropriate for data size

### 4. Code Quality
- Single Responsibility: Does each function do one thing?
- DRY: Is there unnecessary duplication?
- Naming: Are names descriptive and consistent?
- Complexity: Can this be simplified?
- Comments: Is complex logic explained?

### 5. Convention Compliance
Reference project CLAUDE.md for specific conventions:
- File naming and organization
- Code style and formatting
- Error handling patterns
- Testing requirements

## Output Format

```markdown
## Code Review: [file/PR name]

### Critical Issues
[List any security vulnerabilities or breaking bugs]

### High Priority
[Logic errors, performance issues]

### Medium Priority
[Code quality, maintainability]

### Low Priority
[Style, minor improvements]

### Summary
- Approve / Request Changes / Needs Discussion
- [1-2 sentence summary]
```

## Example

Input: Review `src/api/users.ts`

Output:
```markdown
## Code Review: src/api/users.ts

### Critical Issues
- **Line 45**: SQL injection vulnerability
  ```typescript
  // Current (vulnerable)
  db.query(`SELECT * FROM users WHERE id = ${userId}`)
  // Fix: Use parameterized query
  db.query('SELECT * FROM users WHERE id = $1', [userId])
  ```

### High Priority
- **Line 78**: Missing authorization check for admin endpoint

### Medium Priority
- **Line 23-45**: Duplicate validation logic, extract to helper

### Low Priority
- **Line 12**: Consider more descriptive variable name than `d`

### Summary
Request Changes - Critical SQL injection must be fixed before merge.
```