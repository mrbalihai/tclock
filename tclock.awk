function collectActive () {
    if (prev == "i" && $1 == "o") {
        len--
        delete active[len]
    }
    if ($1 == "i") {
        active[len++] = substr($0, 3)
    }
    prev = $1;
}

function printActive () {
    for (e in active) {
        split(active[e], entry, " ");
        duration = systime() - mktstamp(entry[1]" "entry[2]);
        printf "%s %s ", formatTime(duration), entry[3];
        delete entry[1];
        delete entry[2];
        delete entry[3];
        for (i in entry)
            printf "%s ", entry[i];
        printf "\n"
    }
}

function collectSummary (dateFilter, categoryFilter) {
    # Consecutive matching i and o entry
    # TODO: take into account entries > 1d - how to filter
    #   and how to only count the time elapsted since midnight
    # TODO: include open entries
    catRegex = "^"categoryFilter;
    if (prev == "i" && $1 == "o" && $2 == dateFilter && cat ~ catRegex) {
        # Convert dddd-mm-yy hh:mm:ss to timestamp in seconds and diff
        sec=mktstamp($2" "$3) - mktstamp(idatetime);
        cats[cat] = cats[cat] + sec;
    };

    if ($1 == "i") {
        cat = $4;
        idatetime = $2" "$3;
        idate = $2;
    }
    prev = $1;
}

function printSummary() {
    for (c in cats) {
        printf "%15s %s\n", formatTime(cats[c]), c;
        total = total + cats[c]
    }
    print "---------------"
    printf "%15s\n", formatTime(total)
}

function printEntries(dateFilter, categoryFilter) {
    catRegex = "^"categoryFilter;
    if (prev == "i" && $1 == "o" && $2 == dateFilter && cat ~ catRegex) {
        # Convert dddd-mm-yy hh:mm:ss to timestamp in seconds and diff
        sec=mktstamp($2" "$3) - mktstamp(idate);
        printf "%15s %-30s %s\n", formatTime(sec), cat, desc;
    };

    if ($1 == "i") {
        cat = $4;
        idate = $2" "$3;
    }
    prev = $1;

    # Unset everything else to get the remaining args as the description
    $1 = "";
    $2 = "";
    $3 = "";
    $4 = "";
    desc = substr($0, 5);
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

    res = sprintf("%ds", remsec);

    if (mins > 0)
        res = sprintf("%dm", remmins)" "res;

    if (hours > 0)
        res = sprintf("%dh", hours)" "res;

    return res;
}
