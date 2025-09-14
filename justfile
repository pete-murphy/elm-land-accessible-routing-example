default:
    just --list

run:
    elm-land server

sort flag="--write":
    #!/usr/bin/env bash
    set -eu
    rustywind {{flag}} --custom-regex "\bclass[\s(<|]+\"([^\"]*)\"" .
    rustywind {{flag}} --custom-regex "\bclass[\s(]+\"[^\"]*\"[\s+]+\"([^\"]*)\"" .
    rustywind {{flag}} --custom-regex "\bclass[\s<|]+\"[^\"]*\"\s*\+{2}\s*\" ([^\"]*)\"" .
    rustywind {{flag}} --custom-regex "\bclass[\s<|]+\"[^\"]*\"\s*\+{2}\s*\" [^\"]*\"\s*\+{2}\s*\" ([^\"]*)\"" .
    rustywind {{flag}} --custom-regex "\bclass[\s<|]+\"[^\"]*\"\s*\+{2}\s*\" [^\"]*\"\s*\+{2}\s*\" [^\"]*\"\s*\+{2}\s*\" ([^\"]*)\"" .
    rustywind {{flag}} --custom-regex "\bclassList[\s\[\(]+\"([^\"]*)\"" .
    rustywind {{flag}} --custom-regex "\bclassList[\s\[\(]+\"[^\"]*\",\s[^\)]+\)[\s\[\(,]+\"([^\"]*)\"" .
    rustywind {{flag}} --custom-regex "\bclassList[\s\[\(]+\"[^\"]*\",\s[^\)]+\)[\s\[\(,]+\"[^\"]*\",\s[^\)]+\)[\s\[\(,]+\"([^\"]*)\"" .
