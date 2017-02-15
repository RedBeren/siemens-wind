# siemens-wind
Siemens Wind Competition 2017

## Tasks
### 1. Association Analysis
Investigate the codes leading up to the visit for patterns in seeing either particular codes or a specific
pattern of code sequence. Ideas: look at between/among different sites, different groups of
turbine types, seasonality indications, time of day the visit occurs (within vs outside expected
working day hours).

Generate common sequences or paths among the all alarm sequences. Can visits be segmented
according to these common paths?

### 2. Categorize/Cluster Analysis; Correlations
Investigate commonalities by various factors: time of day of
visit start, quantities of codes associated with the visit, what percent of total turbines at the same Park
were visited on the same day, similarity of type or pattern of associated codes, length of the visit (very
short, <5 minutes vs 25 minutes), and/or other various provided Factors.

What variables are significant indicators of visit duration or visit segmentation (from task 1
above)?

### 3. Code Timing
Consider not just patterns and occurrence of codes, but also the timing of the codes relative to each
other. Your analysis should distinguish between a code sequence spread out over many hours vs. just a
few minutes. Remember, some codes occur on every turbine on a periodic basis as a matter of normal
operation; so the occurrence of a code may, or may not, be relevant to the visit.

### 4. Before/After Visit
Consider breaking the analysis into codes and patterns occurring prior to the Visit code, separately
from those occurring on or after the Visit code starts. Classifying visits in groups or clusters with similar
“before visit” behavior vs. “after visit” behavior can provide valuable insight. There may be codes during
the visit which indicate similar work was performed, even if/when no pattern is apparent in the codes
leading up to the visit, and vice versa. Be able to capture a similarity, even if it only exists in the pre-visit
codes or in the during-visit (or after-visit) codes.

### 5. Locality
Take special note of many turbines at a Park being visited on the same day. It may be useful to
specifically seek out visits occurring on the same day at a site, as this could be an indication of a common
task or cause. On the other hand, there may be a pattern or oddity noted in investigating only “one-off”
visits (where only one turbine experienced a visit at a Park in a single day) vs. the occurrence of multiple
visits to various turbines at a Park in a day.

### Bonus Info
Not every instance of a local/remote switch signal input might actually be caused by a physical
turning of the switch at the turbine. It is possible that some sort of electrical glitch could cause the
switch input signal to latch in, when a technician is not actually activating the input. Absence of
additional turbine codes in the hours proceeding or during the visit could indicate this. A second
clue to this situation would be observing many visit starts occurring simultaneously (or nearsimultaneously)
across a significant portion of turbines at any specific Park (it’s unlikely that a
limited # of teams would be at every turbine at once and/or putting the turbine into local mode
simultaneously). A third clue to this situation could be observing abnormal Visit Start Times
outside of what is normally seen at a Park -- generally before 6AM or after 8PM. Siemens is
particularly interested in identifying any code “signature” which indicates visits could fall into this
category of “potential electrical glitches”.
