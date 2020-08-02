json.member @members do |member|
  json.partial! 'members/member', member: member
  json.number_of_friends member.friendships.count
end

