ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    # div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #   span :class => "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Users" do
          ul do
            User.all.map do |user|
              li link_to(user.fullname, admin_user_path(user))
            end
          end
        end
      end

      column do
        panel "Recent Shops" do
          table_for Shop.order("created_at desc").limit(5) do
            column :name do |shop|
              link_to shop.name, admin_shop_path(shop.id)
            end
          end
        end
        panel "Recent Items" do
          table_for Item.order("created_at desc").limit(5) do
            column :name do |item|
              link_to item.name, admin_item_path(item.id)
            end
          end
        end
      end
    end
  end # content
end
