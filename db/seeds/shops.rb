#
# Items for MMA
#
shop_id = 1
["MMA", "Junk"].each_with_index do |user_name, user_idx|
  user_id = user_idx+1
  ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"].each_with_index do |shop_num, shop_idx|
    Shop.create :id => shop_id,
                :name => "#{user_name} Shop #{shop_num}",
                :description => "Shop number #{shop_num} for #{user_name} ",
                :user_id => user_id
    puts "#{user_name}:#{user_id} Shop #{shop_num}:#{shop_id}"
    shop_id = shop_id + 1
  end
end
