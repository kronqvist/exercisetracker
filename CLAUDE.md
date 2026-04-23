# Exercise Tracker

## Project Overview

A single-file PWA exercise tracker (`index.html`) using browser localStorage. No backend. Designed for daily tracking of rehabilitation and strength exercises.

## User's Clinical Condition

The user has a documented lumbar-pelvic condition requiring ongoing rehabilitation. Treating chiropractor: Fredrik Christiansson (Leg. Kiropraktor, Incuro AB, Stockholm). Diagnoses: M99.0 Segmental dysfunction, M79.1 Myalgia, M79.1F Myalgia hip/thigh.

### Baseline Findings

- **Structural leg length discrepancy (LLD):** Right leg longer than left, causing compensatory lateral pelvic tilt and functional lumbar scoliosis
- **Lumbar spine:** Progressive degenerative disc changes at L3-L4, L4-L5, and L5-S1, including a medial annular fissure at L4-L5 and symmetric disc bulge at L5-S1
- **Left SI joint:** Chronic sacroiliitis with mechanical irritation, positive impingement sign, restricted internal rotation of left hip
- **Muscular pattern:** Hypertonicity in left TFL, iliopsoas, gluteus medius, tractus band, deep hip rotators, and inguinal ligament area. Over-reliance on rectus femoris for hip flexion. Reduced hip adduction strength due to active inflammation. Right side compensatorily tense; left side carries the active tension pattern.
- **Clinical signs:** Nachlas positive bilaterally, Figure 4 positive, hip extension positive left

### Visit 2025-12-29 — Initial Assessment Summary

LLD measured at 12 mm (present in both prone and supine). Internal rotation clearly reduced with impingement tendency on left. Reduced adduction strength, likely due to pain/irritation. Recommended: core exercises, hip thrusts with simultaneous abduction and adduction, banded reciprocal cycling with transversus abdominis activation ("tuck under"), self-pressure on deep hip rotators and gluteus medius. Referred to orthopedist for hip joint evaluation.

### Visit 2026-03-17 — Follow-up

Orthopedist referral completed: plain radiograph unremarkable. Anti-inflammatory prescribed but discontinued due to allergic reaction. Continued rehabilitation exercises independently.

Progress: LLD reduced from 12 mm to approximately 6 mm. Pelvic positioning more symmetrical in prone. Muscle tension more balanced and bilateral, though still elevated. Glute activation now symmetrical and early-firing.

Remaining deficits: left gluteus medius and deep rotators still hypertonic. Left internal rotation provokes SI joint pain. Left internal rotation passively more mobile but causes inguinal pain; inguinal ligament palpation-tender on left. Adductor longus and psoas show strength on left but with hesitant activation compared to distinct right-side recruitment. Adductor brevis bilaterally strong without pain.

Treatment: myofascial release (QL, glutes, deep hip rotators, TFL, iliopsoas, inguinal area — all left), manual hip traction for tendon passage clearance. Recommended: hip thrusters, alternating air cycling with band around feet, banded hip flexion.

### MR 2026-04-13 — Lumbar Spine, Pelvis, Hips, SI Joints

Compared against MR from 2024-10-02; essentially unchanged.

**Lumbar spine:** Straightened lordosis. Discs L3-S1 degeneratively dehydrated; L5-S1 markedly reduced height with surrounding Modic type 1 changes. L3-L5: minor annular fissures and flat median disc bulges without nerve root involvement. L5-S1: degenerated, broad-based disc bulge. No root compression, no disc herniation, no spinal stenosis. Conus normal. Root canals without narrowing. No anterior spondylitis. No malignancy.

**Pelvis/hips/SI joints:** No arthrosis or arthritis in the hip joints. Sacroiliac joints appear normal without ankylosing changes, erosions, or surrounding bone marrow oedema. No sacroiliitis.

### Prescribed Rehabilitation Objectives

1. **Inhibition:** Myofascial release of deep hip rotators and gluteus medius to reduce neural irritation. Self-pressure with tennis ball on glute musculature.
2. **Stabilization:** Transversus abdominis activation ("tuck under" maneuvers) to eliminate lumbar hyper-lordosis during movement
3. **Integration:** Hip thrusts with simultaneous ball squeeze (adduction) and band resistance (abduction) to stabilize pelvic girdle. Banded reciprocal air cycling with tuck-under for motor control. Banded hip flexion to retrain psoas/adductor recruitment over rectus femoris.

## Overall Goal

Overcome the biomechanical issues described above and become overall stronger. All features should be designed to support consistency, progressive loading, and balanced rehabilitation coverage.

## Progressive Overload Algorithm

Volume must rise, but slowly; the body adapts on its own schedule. The green zone algorithm honours this by anchoring to proven capability rather than recent activity.

Two EWMA time scales, both normalised to weekly volume:

- **Display EWMA** (14-day half-life, 56-day lookback): the blue curve on the zone chart and the "EWMA/wk" stat. Responsive to recent changes, shows current training state.
- **Baseline EWMA** (60-day half-life, 240-day lookback): used only for green zone calculation. Sluggish by design; short bursts of intense training barely move it. Only sustained, consistent volume over months can shift the baseline upward.

The baseline is `bestEwma(id)`: the highest baseline-EWMA weekly volume ever recorded for a given exercise. This value can only ratchet upward. The green zone spans 100 to 115% of this peak. A minimum of 90 days of data is required before the baseline activates.

Home-page dots (green / yellow / red / grey) and the detail-view zone chart both derive from `bestEwma()`. The chart plots the daily display-EWMA against a green band derived from the running-best baseline-EWMA.

## Critical Rules

- **No changes are allowed that would overwrite existing user data.** All data in localStorage is irreplaceable. Any feature that writes to localStorage must preserve existing entries. Import/merge operations must confirm with the user before touching any key that already has a value.
- **Every change must bump the version number** in `service-worker.js` (`APP_VERSION` constant). This ensures the PWA cache is invalidated and users get the latest version.
- **Summary format:** When done with a change, format the summary like a git commit — a short title line (imperative mood, under 70 chars) followed by a body describing what changed and why.

## Design Principles

- **Keep implementations data-driven, not hard-coded.** Features should derive behavior from the exercise config (`EXERCISES` array) and its properties (`dpw`, `clr`, `unit`, etc.) rather than containing exercise- or category-specific logic. Adding a new exercise or category should only require adding an entry to the config — not touching feature code. New features should scale O(n) with the number of exercises, not O(n^2) with feature-exercise combinations.
- **Readable code over compact code.** Favour intermediate variables, named conditions, and short single-purpose functions over dense one-liners. A line of code should be parseable at a glance; if it needs a second read, break it apart.

## Technical Notes

- Entire app lives in `index.html` (HTML + CSS + JS, no build step)
- Data stored in localStorage with keys: `ex:{exerciseId}:{YYYY-MM-DD}:count` and `ex:{exerciseId}:{YYYY-MM-DD}:notes`
- PWA with service worker for offline support
- Dark theme, mobile-first design
