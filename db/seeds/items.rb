#
# Items
#
item_id = 1
["MMA", "Junk"].each_with_index do |user_name, user_idx|
  user_id = user_idx+1
  ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"].each_with_index do |shop_num, shop_idx|
    shop_id = shop_idx+(user_idx*10)+1
    ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"].each do |item_num|
      price_val = Random.rand(10..50)
      quant_val = Random.rand(1..7)
      act_val = (Random.rand(1..3) == 2)
      shop = Shop.find(shop_id)
      Item.create :db_seeding => true,
                  :id => item_id,
                  :name => "#{user_name} Shop #{shop_num} item #{item_num}",
                  :description => "Incredible item #{item_num} in #{user_name} Shop #{shop_num}",
                  :price => price_val,
                  :quantity => quant_val,
                  :active => act_val,
                  :shop => shop,
                  :shop_id => shop_id
      puts "#{user_name} Shop #{shop_num}:#{shop_id} item #{item_num}:#{item_id}, P#{price_val}, Q#{quant_val}, A#{act_val}"
      item_id = item_id + 1
    end
  end
end
