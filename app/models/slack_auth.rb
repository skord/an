class SlackAuth < Authentication

  def token
    credentials.token
  end

  def api_client
    @api_client ||= Slack::Web::Client.new(token: token)
  end

  def slack_api_users
    @slack_api_users ||= api_client.users_list.members
  end

  def local_slack_friends
    slack_api_user_ids = slack_api_users.collect {|x| x.id}
    User.where(id: Authentication.where(uid: slack_api_user_ids, provider: 'slack'))
  end

  def local_slack_friend_ids
    local_slack_friends.pluck(:id)
  end
end
