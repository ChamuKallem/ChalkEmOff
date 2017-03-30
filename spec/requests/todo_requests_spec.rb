require 'rails_helper'
describe 'todo_tests', type: :request do
  before do
    user = sign_in
    @id = user.id
  end

  let!(:todos) { create_list(:todo, 10, user_id: @id) }
  let(:todo_id) { todos.first.id }

  describe 'GET /v1/todos' do
    before { get "/v1/todos"}
    it "returns success" do
      expect(response).to be_success
    end
    it "returns the list of todos" do
      expect(json['data'].length).to eq(10)
    end
  end
  describe 'GET /todos/:id' do
    before { get "/v1/todos/#{todo_id}"}
    it "returns success" do
      expect(response).to be_success
    end
    it "returns the todo" do
      expect(json).not_to be_empty
      expect(json['data']['id']).to eq(todo_id.to_s)
    end
  end
  describe 'POST todos' do
    let(:todo_values) { {title: "Kitchen List", complete: false, user_id: @id}}
    before { post '/v1/todos', params: todo_values}
    it "returns success" do
      expect(response).to be_success
    end
    it "creates a todo" do
      expect(json['data']['attributes']['title']).to eq('Kitchen List')
    end
    it "increases todo count by 1" do
      expect{ post '/v1/todos', params: {title: "Costco List", complete: false, user_id: @id}}.to change(Todo, :count).by(1)
    end
  end
  describe 'POST todos with invalid - empty title' do
    before { post '/v1/todos', params: {title: "", user_id: @id}}
    it 'returns a validation failure message' do
      json['data']
      expect(json['data']['attributes']['title']).to be_empty
    end
  end
  describe 'DELETE /todos/:id' do

    it "reduces todo count by 1" do
      expect{ delete "/v1/todos/#{todo_id}" }.to change(Todo, :count).by(-1)
    end
    let(:todo_id) { todos.first.id }
    it "returns status code" do
      delete "/v1/todos/#{todo_id}"
      expect(response).to have_http_status(204)
    end
  end

end
