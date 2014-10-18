# Create dark and mysterious administrator!
wrestler = User.find_or_create_by(uid: 'wrestler') do |user|
  user.name = 'Bam Bam Bigelow'
  user.email = 'wrestler@railsrumble.com'
end

# Create default rooms for demo usage
DefaultRooms.list.each do |group_name|
  unless Room.find_by_name group_name
    Rooms::Creator.new(owner: wrestler, name: group_name).call
  end
end
