# CLAUDE.md

## Project Overview

This repository is **Knowledge**, a Java web application packaged as a WAR.

## Working Rules

- **Do not run `mvn` directly during development.** Use `./launch.sh` for build and run workflows.
- Use `./launch.sh --build-only` when you only need to confirm that the build succeeds.
- Prefer the existing project scripts and Docker-based flow over inventing new commands.
- Keep changes small and aligned with the current codebase; this is an older application with legacy dependencies.
- Avoid upgrading core tooling, frameworks, or dependency versions unless the task explicitly asks for it.

## Work Items

- Use `work-items/` for active change requests and implementation notes.
- Move completed items to `work-items/done/` when the work is finished.
- Keep `work-items/` focused on reusable instructions, acceptance criteria, and verification steps.
- Do not use `work-items/` for scratch notes that are only useful during a single session.

## Development Flow

- If the `third_party/markedj` directory is missing, `./launch.sh` will clone it automatically.
- `./launch.sh` builds the project in Docker, produces `target/knowledge.war`, copies it to `target/webapps/ROOT.war`, and starts Tomcat.
- `./launch.sh --build-only` runs the same build steps but exits before starting Tomcat.
- Use the logs from `launch.sh` / Docker to confirm behavior after changes.

## Repository Notes

- Main app code lives under `src/main/java` and `src/main/webapp`.
- Configuration and SQL live under `src/main/resources`.
- `third_party/markedj` is a maintained vendored dependency in this workspace and may also be modified when needed.
- Build artifacts and local state such as `target/`, `.m2/`, `.postgres/`, `.es_data/`, and `.knowledge/` are ignored by git.

## Verification

- Prefer verifying changes by running `./launch.sh` and checking that the app starts cleanly.
- If a change only affects static assets or documentation, mention that a full launch was not necessary.
