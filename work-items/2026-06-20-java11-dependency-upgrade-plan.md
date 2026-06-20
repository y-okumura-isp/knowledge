# Java 11 Dependency Upgrade Plan

## Goal

Move the application forward from the current Java 11 baseline by upgrading old dependencies in a controlled order.
The work should be split across multiple commits and may span multiple sessions, so this plan is meant to be a stable handoff point.

## Scope

- `pom.xml`
- `launch.sh` when build/test behavior needs to be adjusted for verification
- `Dockerfile` and `docker-compose.yml` only if a dependency upgrade requires runtime image changes
- Source code touched by dependency API changes

## Constraints

- Keep each change small and reviewable.
- Prefer dependency groups with the smallest blast radius first.
- Preserve existing behavior unless a dependency upgrade forces a change.
- Verify each step with `./launch.sh --build-only`.
- Keep Java 11 compatibility as the baseline until the application is stable there.

## Upgrade Order

1. Low-risk, narrowly used libraries
   - `com.google.code.gson:gson`
   - `commons-fileupload:commons-fileupload`
   - `org.apache.httpcomponents:httpclient`
   - `commons-lang:commons-lang`
   - `org.javassist:javassist`

2. Build and test tooling
   - `junit:junit`
   - Maven plugins such as compiler, checkstyle, pmd, findbugs

3. Java EE and XML/JAXB-related libraries
   - JAXB / activation dependencies
   - Servlet / websocket / JSTL / Java EE API dependencies
   - Tomcat embedded/runtime images if needed

4. Larger or riskier application libraries
   - `org.apache.tika:tika-parsers`
   - `org.apache.lucene:*`
   - `org.pegdown:pegdown`
   - `simple-xml`, `jsonic`, `guava`, `directory-api`, mail stack, `log4j`

## Acceptance Criteria

- [ ] The dependency upgrade order is recorded and can be resumed in a later session.
- [ ] Each dependency upgrade is verified with `./launch.sh --build-only` before moving on.
- [ ] No upgrade step merges unrelated refactors.
- [ ] The next work item can be picked up without re-reading the whole repository.

## Verification

- [ ] `./launch.sh --build-only`
- [ ] Run focused tests if a specific library change affects a small code path

## TODO

- [x] Start with the low-risk libraries, likely `gson` or `httpclient`.
- [ ] After each upgrade, note the affected source files and any API changes.
- [x] Keep one commit per dependency group when practical.
- [ ] If a dependency update forces runtime image changes, update `Dockerfile` or `docker-compose.yml` in the same commit.
- [ ] Record any blockers or follow-up work in this file so the next session can continue cleanly.

## Progress

- `gson` updated to `2.10.1` and verified with `./launch.sh --build-only`.
- `httpclient` updated to `4.5.14`.
- Added `HttpLogicTest` to cover proxy and non-proxy `createHttpClient()` behavior.
- Full build and UT run pass on Java 11.

## Notes

- Java 11 migration is already complete and verified.
- The current build/test flow is still driven by `./launch.sh`.
- `JaCoCo` currently passes under Java 11, so the next work is dependency modernization rather than compiler recovery.
