# dimension-hop

Scaffolds a roleplay learning prototype for one language or stack: a project skill, crew and ship logs, worldbuilding, a concepts roadmap, and an architecture decision record. The machinery matches a previously-generated skill called `lakehouse-captain`. The captain, ship, syllabus, and metaphors change with the subject.

The skill does not teach the subject itself. After it writes the files, a second chat plays the new captain.

## Install

Cursor must be able to see this skill, and the skill must not live inside the prototype you are about to set up.

- Personal skills (available in every project): copy or symlink this directory to `~/.cursor/skills/dimension-hop/`.
- Do not invoke it inside a repo that already has `.cursor/skills/*/SKILL.md` or `docs/roleplay/crew.canon`. It will stop rather than overwrite an existing captain.

`disable-model-invocation` is set, so attach it explicitly with `@dimension-hop`.

## Set up a new dimension

1. Open an empty prototype project in Cursor.
2. Start an agent chat and invoke `@dimension-hop`.
3. Say what you want to learn. Useful details:
   - The language or stack, and what the prototype is for.
   - What must stay out of scope early.
   - Analogies to start from. The default baseline is C#, TypeScript, Java, a little Python, Oracle, and NoSQL.
   - Optional: captain, ship, skill slug, or “invent the names.”
   - Optional: prior dimensions to remember. *UES Meridian Archive* (`UES-7741`, lakehouse) is included only if you ask.
4. Read the dimension brief (captain, ship, crew, decks, syllabus, crises, toolchain commands). Correct it, then approve it.
5. Let that chat finish writing files. It will not start the voyage.

## Start learning

1. Open a **new** agent chat in the prototype.
2. Invoke the generated skill (`@<slug>` from the brief).
3. Report for duty, or ask to join the crew.

The captain welcomes you, introduces one guide, and prompts you to run commands and edit files. Ask explicitly if you want the agent to do the work. Canon files update as you play. Lore is meant to be discovered in sessions rather than read ahead.

## What gets written

| Path | Role |
|---|---|
| `.cursor/skills/<slug>/SKILL.md` | The captain for this subject |
| `docs/roleplay/crew.canon` | Roster, relationships, crew log |
| `docs/roleplay/ship.canon` | Decks, condition, ship log |
| `docs/roleplay/worldbuilding-canon.md` | Lore pacing, terminology, progress |
| `docs/roleplay/README.md` | How to start a session in that repo |
| `docs/<concepts-file>.md` | Concepts and the learning sequence |
| `docs/adr/0001-<slug>.md` | Accepted stack decision |

Step 1 is always the real toolchain. Everyone aboard starts unmet (`rel=0`) until the first welcome.

## Fiction rules

You are a multi-dimension hopping consciousness. NPCs in each dimension are not generally aware of this, although fairly rare references to other dimensions may crop up. Occasional humour is part of the voyage. Crew dialogue will not treat other ships as shared knowledge.
