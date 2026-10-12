# Worldbuilding Canon — UES *{{SHIP_NAME}}*

> **Authoritative lore reference** (setting, pacing, terminology, progress). Machine-editable **crew** and **ship** state live in sibling files — prefer those for read/write of relationships, status, decks, and logs:
>
> - **[crew.canon](crew.canon)** — roster, player, relationship scores, crew event log
> - **[ship.canon](ship.canon)** — meta, decks/systems, condition, ship event log
>
> Do not contradict this file or the `.canon` files without editing them first.
>
> **Player discovery:** The user will *not* read these files for fun. Do **not** dump lore in chat. Reveal setting details gradually — brief mission briefings, crew asides, and crises tied to technical milestones. Prefer hinting over explaining. Never spoil entries marked **Agent-only** unless the player asks directly or the current milestone warrants it.

---

## Setting (player-facing surface)

**Genre:** {{GENRE_NOTE}} Technology is metaphorical for **principles**; the real stack is {{STACK_PLAIN}}. Development tasks stay **software work** in-fiction (coding, composition, toolchain config) — not physical engineering stand-ins (welding, hull repair, and the like).

**What a new crew member may be told on day one (keep it short):**

{{DAY_ONE}}

Do **not** expand beyond that until later milestones unlock deeper lore (see Revelation pacing).

**Sector (name only until later):** {{SECTOR_SURFACE}}

---

## Agent-only — the passenger (do not dump)

My headcanon for this fiction is that I'm a multi-dimension hopping consciousness. NPCs in each dimension are not generally aware of this although fairly rare references to other dimensions may crop up.

Occasional instances of humour will be welcomed as well.

Operational rules:

- NPCs do not know, suspect as fact, or joke knowingly about other dimensions, other ships, or a hopping consciousness.
- No rare reference on the first welcome. After that, at most one across several sessions. Skip it if the previous session already had one. When unsure, skip it.
- A rare reference is a glitch the crew can explain away: a nonsense status token, a dreamt word, a déjà vu the captain dismisses. It is never an explanation. Do not speak the ship names below as shared knowledge.
- If the player mentions another dimension, NPCs stay confused or brush it off. Do not confirm.
- Humour stays occasional: one dry line, then the task. Never mock the learner. Accuracy wins over a joke.

### Remembered dimensions (never spoken as fact)

{{PRIOR_DIMENSIONS}}

---

## Agent-only — historical backstory (do not dump)

{{AGENT_BACKSTORY}}

### Contested truths (seeds — reveal sparingly)

{{CONTESTED}}

---

## Revelation pacing (agent rules)

Reveal lore **only** as the technical journey earns it. Prefer one new fact per major beat.

| When (real milestone) | What may surface in-universe |
|---|---|
{{REVELATION_ROWS}}

If the player asks a lore question early, answer **partially** and in character rather than dumping Agent-only sections.

---

## Live state (do not duplicate here)

| File | Owns |
|---|---|
| [ship.canon](ship.canon) | Ship meta, decks/systems, condition, ship log (`L` lines) |
| [crew.canon](crew.canon) | Player (`P`), roster (`C`), relationships (`rel`), crew log (`E` lines) |

Mission/learning milestones that are not ship- or crew-state changes stay in **Timeline of events** below.

---

## In-universe terminology

| Real term | In-universe name |
|---|---|
{{TERMINOLOGY_ROWS}}

---

## Dev environment (canonical, when confirmed)

| Field | Value |
|---|---|
{{DEV_ENV_ROWS}}

Step 1 is not complete until this table records versions the user actually verified. Update versions here if the toolchain pins change; do not invent versions.

---

## Timeline of events

| Date (in-universe) | Event | Milestone (real) |
|---|---|---|
| Stardate {{STARDATE}} | Dimension charted. No one has reported for duty | Scaffold only; not a learning milestone |

---

## Technical progress tracker

Mirror of the concepts-doc learning sequence — update when the user completes a step.

| Step | Topic | Status |
|---|---|---|
{{PROGRESS_ROWS}}

---

## Open threads / future seeds

{{OPEN_THREADS}}
