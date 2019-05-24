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

  def sklonenie(number, krokodil, krokodila, krokodilov)
    # Сначала, проверим входные данные на правильность
    if number == nil || !number.is_a?(Numeric)
      # Допустим, первый параметр пустой или не является числом (строка). Будем
      # считать, что нас это устроит, просто продолжаем как будто он нулевой.
      number = 0
    end

    if number >= 11 && number <= 14
      return krokodilov
    end
    # Исправление ошибки 112 негритят вместо 112 негритенка
    if number > 100
      ostatok = number % 100
      if ostatok >= 11 && ostatok <= 14
        return krokodilov
      end
    end

    ostatok = number % 10

    # Для 1 — именительный падеж (Кто?/Что? — крокодил)
    if ostatok == 1
      return krokodil
    end

    # Для 2-4 — родительный падеж (2 Кого?/Чего? — крокодилов)
    if ostatok >= 2 && ostatok <= 4
      return krokodila
    end

    # 5-9 или ноль — родительный падеж и множественное число (8 Кого?/Чего? —
    # крокодилов)
    if (ostatok >= 5 && ostatok <= 9) || ostatok == 0
      return krokodilov
    end
  end
end
