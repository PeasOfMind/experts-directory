module MembersHelper
  def search_connections(member, keywords)
    @checked_friends = [member.id]
    search_path = []
    member.friends.each do |friend|
      # start looking at friends of friends
      @checked_friends = @checked_friends.push(friend.id)
      updated_path = recursive_search(friend, keywords.downcase, [member.id, friend.id])
      search_path = updated_path if updated_path.last.is_a? String
    end

    # replace member ids with their name
    search_path.each_with_index do |elem, i|
      if elem.is_a? Numeric
        search_path[i] = Member.find(elem).name
      end
    end
  end

  def recursive_search(member, keywords, search_path)
    return if member.friends.empty?
    member.friends.each do |friend|
      # move on if we've already checked this friend
      next if @checked_friends.include? friend.id 
      @checked_friends.push(friend.id)
      matching_results = friend.profile.select { |heading| heading.downcase.include? keywords }

      if matching_results.any?
        updated_path = search_path + [(friend.id), matching_results.first]
      else
        # recursively check
        updated_path = recursive_search(friend, keywords, search_path + [(friend.id)])
      end
      
      # update search path if we got a match and break from loop
      search_path = updated_path if updated_path.last.is_a? String
      break
    end
    search_path
  end
end
