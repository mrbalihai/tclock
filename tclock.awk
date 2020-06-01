BEGIN {
    FS = "[[:space:]][[:space:]]"
}

function parseSummary() {
    l=split($1, parts, " ")

    # Consecutive matching i and o entry
    if (prev == "i" && parts[1] == "o") {
        # Convert dddd-mm-yy hh:mm:ss to timestamp in seconds and diff
        sec=mktstamp(parts[2]" "parts[3]) - mktstamp(idate);
        groups[grouping] = groups[grouping] + sec;
    };

    if (parts[1] == "i") {
        grouping = ""
        for (i = 4; i <= l; i++)
            grouping = grouping" "parts[i];

        grouping = substr(grouping, 2);
        desc = $2;
        idate = parts[2]" "parts[3];
    }
    prev = parts[1];
}

function printSummary() {
    for (g in groups)
        printf "%9s - %s\n", formatTime(groups[g]), g;
}

function printEntries() {
    l=split($1, parts, " ")

    # Consecutive matching i and o entry
    if (prev == "i" && parts[1] == "o") {
        # Convert dddd-mm-yy hh:mm:ss to timestamp in seconds and diff
        sec=mktstamp(parts[2]" "parts[3]) - mktstamp(idate);
        printf "%s - %s - %s\n", formatTime(sec), grouping, desc;
    };

    if (parts[1] == "i") {
        grouping = ""
        for (i = 4; i <= l; i++)
            grouping = grouping" "parts[i];

        grouping = substr(grouping, 2);
        desc = $2;
        idate = parts[2]" "parts[3];
    }
    prev = parts[1];
}

function mktstamp(date) {
    split(date, dtparts, " ");
    split(dtparts[1], dparts, "-");
    split(dtparts[2], tparts, ":");
    return mktime(dparts[1]" "dparts[2]" "dparts[3]" "tparts[1]" "tparts[2]" "tparts[3]);
}

function formatTime(seconds) {
    remsec = seconds % 60;
    mins = (seconds - remsec) / 60;
    remmins = mins % 60;
    hours = (mins - remmins) / 60;

    return sprintf("%02d:%02d:%02d", hours, remmins, remsec);
}
