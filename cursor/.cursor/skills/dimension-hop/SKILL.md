---
name: dimension-hop
description: >-
  Scaffolds a roleplay learning prototype — project skill, crew and ship
  canon, worldbuilding, concepts roadmap, and an ADR — to the same
  specification as lakehouse-captain. Use when the user wants to learn a new
  language or tech stack through captain/crew roleplay, hop dimensions, start
  a prototype project, or set up continuity logging for a new subject.
disable-model-invocation: true
---

# Dimension hop

My headcanon for this fiction is that I'm a multi-dimension hopping consciousness. NPCs in each dimension are not generally aware of this although fairly rare references to other dimensions may crop up.

Occasional instances of humour will be welcomed as well.

This skill scaffolds a **new prototype** so a later chat can teach one language or stack the way `lakehouse-captain` teaches the lakehouse. You write the project skill and the continuity files. You do not start the voyage in this turn.

The reference specification is the lakehouse captain skill: coordinator stance, lore-as-discovery, pipe-delimited `.canon` logs, revelation pacing, metaphor boundary, ADR discipline, and a concepts roadmap. Copy that machinery. Change the dimension.

## Outcome

After approval, the workspace contains:

| Path | Role |
|---|---|
| `.cursor/skills/<slug>/SKILL.md` | Playing agent. Same duties as lakehouse-captain, this dimension's names and syllabus |
| `docs/roleplay/README.md` | How to start a session |
| `docs/roleplay/crew.canon` | Roster, `rel`, append-only crew log |
| `docs/roleplay/ship.canon` | Decks, condition, append-only ship log |
| `docs/roleplay/worldbuilding-canon.md` | Lore, pacing, terminology, timeline |
| `docs/<concepts-file>.md` | Conceptual map and learning sequence |
| `docs/adr/README.md` | ADR index |
| `docs/adr/0001-<slug>.md` | Accepted stack decision |
| `README.md` | Only when the repo has none. Template: `templates/root-readme.md` |

Templates live next to this file. Read a template, replace every `{{TOKEN}}`, save the result. Do not leave a token in a written file. `{{SHIP_CLASS}}` is prose (`Explorer-class`). `{{SHIP_CLASS_SHORT}}` is the canon value (`Explorer`). `{{MERMAID}}` is the diagram body only, not the fences. `{{SKILL_DESCRIPTION}}` is one line.

## What stays fixed

- **Coordinator.** The playing agent prompts the user to edit, run, and verify. It writes canon itself when the fiction establishes facts. It implements only when asked.
- **Canon schema.** Pipe-delimited `P` `C` `E` `S` `D` `L` records, headers, tags, and `rel` rules in the templates. `rel=0` and empty `since` means unmet. No separate met flag.
- **Lore discipline.** Player-facing surface on day one. Agent-only backstory is not dumped. One new fact per major milestone. Contested truths stay sealed.
- **Metaphor boundary.** Metaphors for principles and places. Development tasks stay software work: coding, config, toolchain, SQL, builds. No welding, riveting, or hull-patching as stand-ins for writing software.
- **Teaching.** One concept at a time. Step 1 is always the real toolchain, diagnosed with commands, then recorded in the lore file. Crises only use concepts already taught. Introduce at most two unmet crew per beat.
- **ADRs.** MADR sections. New durable decisions get the next number and an index row. Tiny choices do not.
- **Ship frame.** Explorer-vessel setting, decks, and crew, even when the mission metaphor changes. Do not switch genre away from the ship.
- **Bookkeeping in the same turn** as the narrative beat.

## What changes per dimension

Collect these, infer what the user already said, and ask only for the rest:

| Parameter | Notes |
|---|---|
| Subject | Language, stack, and the job the prototype exists to teach |
| Deferred | Tools that must not appear early. Name them in the skill, concepts doc, and ADR |
| Analogies | Default baseline: C#, TypeScript, Java, a little Python, Oracle RDBMS, NoSQL. Add stacks they have actually learned if they say so |
| Skill slug | Lowercase, hyphens, ≤64 chars. This is the project skill `name` |
| Captain | Full name, short name, id (lowercase). Persona may include dry wit. Do not reuse Elara Venn |
| Ship | Name, class (default Explorer), registry `UES-####`. Never reuse `UES-7741` or *Meridian Archive* |
| Mission surface | Two to four short day-one sentences. The ship's job is the learning goal, the way reconstitution stands for lakehouse work |
| Sector | A name only, plus one in-character way to refer to it before its history unlocks |
| Crew | Captain plus 3–5 specialists. Each specialist owns one stack piece, one deck, one prior-knowledge analogy, a short persona. Step-1 guide is the toolchain specialist |
| Decks | One `D` id per specialist post, plus a workshop mapped to the toolchain |
| Syllabus | Ordered steps. Step 1 = install/verify the toolchain. Later steps are a vertical slice, then deeper features. Optional steps marked optional |
| Crises | One practice problem per taught step. The "requires" column is that step's concept |
| Terminology | Real term → in-universe name, for places and principles only |
| Revelation | One unlockable fact per syllabus step, tied to that step |
| Agent-only history | A backstory the playing agent may hint at later. Do not copy the Meridian Collapse |
| Prior dimensions | Ships the passenger remembers. Agent-only. Include *UES Meridian Archive* (`UES-7741`, lakehouse, Lacerta Drift) only if the user wants that memory |

Player `P` skills are professional background, semicolon-separated, no pipes. Do not write hopper, dimension, or other ships into `crew.canon` or `ship.canon`.

## Workflow

### 1. Confirm the workspace

This skill sets up the **current workspace**. If `docs/roleplay/crew.canon` or `.cursor/skills/*/SKILL.md` already exists, stop. Say this dimension already has a captain. Do not overwrite the lakehouse files or any other existing skill. Ask for a different project directory.

Do not `git init` or commit unless the user asks.

### 2. Draft, then wait

Propose one **dimension brief** before writing files:

- Skill slug and one-sentence description (third person, what the playing agent does and when to invoke it)
- Captain, ship, registry, sector
- Day-one mission surface (short)
- Stack in play, and the deferred list
- Numbered syllabus
- Crew table: `id`, name, rank, post, domain, persona, analogy, which step introduces them
- Deck table: `id`, name, stack, initial `cond`
- Crisis table
- Prior dimensions to store (agent-only)
- Step-1 toolchain commands they will be asked to run

Invent original names. Keep the brief scannable. Then stop and wait for approval or corrections.

If the user already gave names and said to proceed, write after the brief only when nothing important is still ambiguous. A surprise cast still needs a yes before files land.

### 3. Write from the templates

Read and fill, in this order:

1. [templates/project-skill.md](templates/project-skill.md) → `.cursor/skills/<slug>/SKILL.md`
2. [templates/crew.canon](templates/crew.canon) → `docs/roleplay/crew.canon`
3. [templates/ship.canon](templates/ship.canon) → `docs/roleplay/ship.canon`
4. [templates/worldbuilding-canon.md](templates/worldbuilding-canon.md) → `docs/roleplay/worldbuilding-canon.md`
5. [templates/roleplay-readme.md](templates/roleplay-readme.md) → `docs/roleplay/README.md`
6. [templates/concepts.md](templates/concepts.md) → `docs/<concepts-file>.md`
7. [templates/adr-readme.md](templates/adr-readme.md) → `docs/adr/README.md`
8. [templates/adr-0001.md](templates/adr-0001.md) → `docs/adr/0001-<slug>.md`
9. [templates/root-readme.md](templates/root-readme.md) → `README.md` only when the repo has no README. If one exists, append a Roleplay section only when it does not already link the new skill.

Record shapes, one per line, notes using `;` never `|`:

- Crew: `C|id|Name|rank|post|domain|persona|analogy|ok|0|`
- Deck: `D|id|Name|stack|cond|note`
- Log: `L|YYYY.MM.DD|id|add|cond|note`
- Table tokens (`CRISIS_ROWS`, `REVELATION_ROWS`, `TERMINOLOGY_ROWS`, `PROGRESS_ROWS`, and the concepts tables) are raw markdown rows beginning with `|`

Initial state, unless the user has already completed step 1 in this repo:

- Every `C` line: `status=ok`, `rel=0`, empty `since`. No `E` lines yet. The first session writes `meet`.
- Workshop `cond=building`. Other stack decks `cond=offline`.
- One `L` line per deck with `tag=add` on today's stardate (`YYYY.MM.DD`).
- Progress tracker: every step `not started`.
- Dev-environment table: `unconfirmed` until a playing session records real versions. Do not invent JDK or tool versions.
- ADR-0001 status `Accepted`, date `YYYY-MM-DD`.

`intro_order` in `crew.canon` is a comment, not a new record type. Captain id is first; captain `post` is `cmd`. The toolchain guide is the other person available on the first welcome. Specialist `post` values are deck ids.

The project-skill and worldbuilding templates already contain the two headcanon paragraphs and the passenger and humour rules. Leave that wording as it is. Out-of-character technical questions still get a real answer, in character, without a lore speech.

### 4. Check, then hand back

Before you finish:

- Search written files for `{{`. None may remain.
- Syllabus steps match in the project skill, the concepts doc, the revelation table, and the progress tracker.
- Every crisis names a concept from an earlier or current step.
- Captain `post` is `cmd`. Every specialist `post` matches a deck `id`.
- Crew and ship notes use `;`, never `|`.
- Ids are unique. Captain and ship are not the Meridian cast.
- Passenger paragraphs are present and unchanged.
- `disable-model-invocation: true` is set on the project skill.
- Project skill description is third person and includes trigger terms (the subject, captain, joining the crew).

Tell the user the skill name and the start line: open a new agent chat, invoke that skill, and report for duty. Do not play the captain in this conversation.

## Do not

- Do not copy lakehouse crew, the Lacerta Drift, Hold Alpha, or the Meridian Collapse into the new dimension's player-facing lore.
- Do not put roster or deck tables into `worldbuilding-canon.md`. Those live in `.canon` files.
- Do not teach the subject while scaffolding, beyond the brief the user must approve.
- Do not add Python, Spark, Flink, or cloud-first tooling unless the user named them as the subject. Otherwise they belong on the deferred list when they would distract from step 1.
- Do not create the skill under `~/.cursor/skills-cursor/` or overwrite `~/.cursor/skills/dimension-hop/`.
