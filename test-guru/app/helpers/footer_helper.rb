def github_url(author, repo)
  link_to 'TestGuru','https://github.com/' + author.to_s + '/Rails/tree/master/' + repo.to_s,target: '_blank', rel: 'nofollow', class: 'link'
end

def current_year
  Time.now.year
end

