# Контроллер, управляющий пользователями. Должен уметь:
#
#   1. Показывать страницу пользователя
#   2. Создавать новых пользователей
#   3. Позволять пользователю редактировать свою страницу
#
class UsersController < ApplicationController
  # Загружаем юзера из базы для экшенов кроме :index, :create, :new
  before_action :load_user, except: [:index, :create, :new]

  # Проверяем имеет ли юзер доступ к экшену, делаем это для всех действий, кроме
  # :index, :new, :create, :show — к этим действиям есть доступ у всех, даже у
  # тех, у кого вообще нет аккаунта на нашем сайте.
  before_action :authorize_user, except: [:index, :new, :create, :show]

  # Это действие отзывается, когда пользователь заходит по адресу /users
  def index
    @users = User.all
  end
  # Действие new будет отзываться по адресу /users/new
  def new
    # Если пользователь уже авторизован, ему не нужна новая учетная запись,
    # отправляем его на главную с сообщением.
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?

    @user = User.new
  end

  def create
    # Если пользователь уже авторизован, ему не нужна новая учетная запись,
    # отправляем его на главную с сообщением.
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?

    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, notice: 'Пользователь успешно зарегистрирован!'
    else
      render 'new'
    end
  end

  def edit
  end

  def show
    # берём вопросы у найденного юзера
    @questions = @user.questions.order(created_at: :desc)

    # Для формы нового вопроса создаём заготовку, вызывая build у результата вызова метода @user.questions.
    @new_question = @user.questions.build
  end

  def update
  # пытаемся обновить юзера
  if @user.update(user_params)
    # Если получилось, отправляем пользователя на его страницу с сообщением
    redirect_to user_path(@user), notice: 'Данные обновлены'
  else
    # Если не получилось, как и в create, рисуем страницу редактирования
    # пользователя со списком ошибок
    render 'edit'
  end
end

private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url)
  end

  # Загружаем из базы запрошенного юзера, находя его по params[:id].
  def load_user
    @user ||= User.find params[:id]
  end

  def authorize_user
    reject_user unless @user == current_user
  end

end
