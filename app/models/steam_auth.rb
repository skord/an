class SteamAuth < Authentication
  def steamid
    @steamid ||= SteamId.from_steam_id(SteamId.community_id_to_steam_id(uid.to_i))
  end
  def most_played_games
    steamid.most_played_games
  end

  def games
    steamid.games.collect {|g| g[1]}
  end

  def steam_friends
    steamid.friends
  end

  def local_steam_friends
    User.where(id: Authentication.where(uid: steamid.friends.collect {|x| x.steam_id64}, provider: "steam").pluck(:user_id))
  end

  def local_steam_friend_ids
    local_steam_friends.pluck(:id)
  end
end
