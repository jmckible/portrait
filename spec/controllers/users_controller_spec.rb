require 'rails_helper'

describe UsersController do
  before{ login_as :jordan }

  it 'handles /users with GET' do
    get :index
    expect(response).to be_success
  end

  it 'handles /users/:id with GET' do
    get :show, id: users(:jordan)
    expect(response).to be_success
  end

  it 'handles /users with valid params and POST' do
    admin = users(:jordan)
    expect {
      post :create, user: { name: 'name', email: 'email@mail.com', password: 'password', password_confirmation: 'password', admin: true, active: true }
      expect(response).to redirect_to(users_path)
    }.to change(User, :count).by(1)
  end

  it 'handles /users/:id with valid params and PUT' do
    user = users(:jordan)
    put :update, id: user.to_param, user: { name: 'new' }
    expect(user.reload.name).to eq('new')
    expect(response).to redirect_to(users_path)
  end

  it 'handles /users/:id with invalid params and PUT' do
    user = users(:jordan)
    put :update, id: user, user: { password: '',password_confirmation: '' }
    expect(user.reload.name).not_to be_blank
    expect(response).to be_success
    expect(response).to render_template(:show)
  end

  it 'handles /users/:id with DELETE' do
    expect {
      delete :destroy, id: users(:daniela)
      expect(response).to redirect_to(users_path)
    }.to change(User, :count).by(-1)
  end

end
