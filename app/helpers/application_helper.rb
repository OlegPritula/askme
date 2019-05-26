# В этом файле мы можем писать вспомогательные методы (хелперы) для
# шаблонов (view) нашего приложения.
module ApplicationHelper
  # Этот метод возвращает ссылку на автарку пользователя, если она у него есть.
  # Или ссылку на дефолтную аватарку, которая лежит в app/assets/images
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def counter_questions(number, vopros, voprosa, voprosov)
    if (number % 100).between?(10,14) || (number % 10).between?(5,9) || (number % 10) == 0
      voprosov
    else
      (number % 10) == 1 ? vopros : voprosa
    end
  end
end
