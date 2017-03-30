require 'rails_helper'
describe 'todo_items_tests', type: :request do
  before do
    user = sign_in
    @id = user.id
  end
  let!(:todo) {create(:todo, user_id: @id)}
  let!(:items) { create_list(:item, 20, todo_id: todo.id) }

  let(:todo_id) { todo.id }
  let(:item_id) {items.first.id}


  describe 'GET /v1/todos/:todo_id/items' do
    before { get "/v1/todos/#{todo_id}/items"}
    it "returns success" do
      expect(response).to be_success
    end
    it "returns the list of todo-items" do
      # puts json['data']
      expect(json['data'].length).to eq(20)
    end
  end
  describe 'GET /v1/items/:id' do
    # before { get "/v1/todos/#{todo_id}/items/#{itemd_id}"}
    before { get "/v1/items/#{item_id}"}
    it "returns success" do
      expect(response).to be_success
    end
    it "returns the item" do
      expect(json).not_to be_empty
      expect(json['data']['id']).to eq(item_id.to_s)
    end
  end
  describe 'POST items' do
    let(:item_values) { {name: "Bring a bag of Avacados from Costco", complete: false}}
    before { post "/v1/todos/#{todo_id}/items", params: item_values}
    it "returns success" do
      expect(response).to be_success
    end
    it "creates a item in todos" do
      expect(json['data']['attributes']['name']).to eq('Bring a bag of Avacados from Costco')
    end
    it "increases todo count by 1" do
      expect{ post "/v1/todos/#{todo_id}/items", params: {name: "Bring a box of Tomatoes from Costco", complete: false}}.to change(Item, :count).by(1)
    end
  end
  describe 'POST items with invalid - empty name' do
    before { post "/v1/todos/#{todo_id}/items", params: {name: ""}}
    it 'returns a validation failure message' do
      expect(json['data']['attributes']['name']).to be_empty
    end
  end
  describe 'DELETE /v1/items/:id' do
    it "reduces items count by 1" do
      puts "before"
      puts Item.count
      expect{ delete "/v1/items/#{item_id}" }.to change(Item, :count).by(-1)
      puts "after 1st delete"
      puts Item.count
    end
    let(:item_id) { items.last.id }
    it "returns status code" do
      delete "/v1/items/#{item_id}"
      expect(response).to have_http_status(204)
      puts "after 2nd delete"
      puts Item.count
    end
  end

end
