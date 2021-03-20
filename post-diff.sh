#!/bin/bash
set -e

if [[ ! -d .pdf ]] || (!(find   .pdf -mindepth 1 | read)); then
    echo "nothing to diff"
    exit
fi

function post_diff {
    left="$1"; shift
    right="$1"; shift

    response=$(curl "https://api.draftable.com/v1/comparisons" \
        -H "Authorization: Token $DRAFTABLE_API_TOKEN" \
        -F "left.file_type=pdf" -F "left.file=@$left" \
        -F "right.file_type=pdf" -F "right.file=@$right" \
        -F "public=true")

    id=$(echo "$response" | jq .identifier -r)

    echo "https://api.draftable.com/v1/comparisons/viewer/$DRAFTABLE_API_ID/$id"
}

function build_content {
    pushd .pdf > /dev/null

    echo "Build successfully finished. Document diff:"

    for item in $(find . -name '*.pdf'); do
        gh_pages_one="../_gh_pages/$item"
        right="$item"

        if [[ ! -f "$gh_pages_one" ]]; then
            left="$item"
        else
            left="$gh_pages_one"
        fi

        url=$(post_diff "$left" "$right")
        
        if [ "$left" != "$right" ]; then
            echo "[$item]($url)"
        else
            echo "[$item]($url) &mdash; new document"
        fi
    done

    popd > /dev/null
}

function post_comment {
    content="$1"; shift

    body=$(jq -n --arg content "$content" '{body: ($content)}')
    GH_BOT_TOKEN=$(curl https://darkkeks.me/hse-bot-token)

    curl -X POST \
        -u hse-tex-bot:$GH_BOT_TOKEN \
        -H "Accept: application/vnd.github.v3+json" \
        $GITHUB_API_URL/repos/$GITHUB_REPOSITORY/issues/$PULL_REQUEST_NUMBER/comments \
        -d "$body"
}

content=$(build_content)

echo "Content:"
echo "$content"

post_comment "$content"
