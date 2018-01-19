require 'rails_helper'

RSpec.describe "Device API", type: :request do
  # initialize test data
  let!(:devices) { create_list(:device, 110) }
  let(:device_id) { devices.first.id }

  # Test suite for GET /devices
  describe 'GET /devices' do
    # make HTTP get request before each example
    before { get '/devices' }

    it 'returns devices' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(110)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /devices/:id
  describe 'GET /devices/:id' do
    before { get "/devices/#{device_id}" }

    context 'when the record exists' do
      it 'returns the device' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(device_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:device_id)  { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Device/)
      end
    end
  end

  # Test suite for POST /devices
  describe 'POST /devices' do
    # valid payload
    let(:valid_attributes) { { name: 'temperature', MAC: '1234567' } }

    context 'when the request is valid' do
      before { post '/devices', params: valid_attributes }

      it 'creates a device' do
        expect(json['name']).to eq('temperature')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/devices', params: { name: 'humidity' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Mac can't be blank/)
      end
    end
  end

  # Test suite for PUT /devices/:id
  describe 'PUT /devices/:id' do
    let(:valid_attributes) { { name: 'test_name' } }

    context 'when the record exist' do
      before { put "/devices/#{device_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'return status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /devices/:id
  describe 'DELETE /devices/:id' do
    before { delete "/devices/#{device_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

  # Test trash capabilities: DELETE /devices/:id, PUT /device/trash/:id
  describe 'DELETE /devices/:id put item to trash' do
    before { delete "/devices/#{device_id}" }

    it 'has items in trash' do
      get '/devices/trash'
      expect(json.size).to eq(1)
    end
  end

  # restore item from trash
  describe 'PUT /devices/trash/:id' do
    before {
      delete "/devices/#{device_id}"
      put "/devices/trash/#{device_id}"
    }

    it 'has no item in trash' do
      get '/devices/trash'
      expect(json).to be_empty
    end

    it 'has all devices available' do
      get '/devices'
      expect(json.size).to eq(110)
    end
  end

  # Test paging capabilities: GET /devices/pages
  describe 'GET /devices/pages provide a page with device list by 50 devices on each page' do
    before { get '/devices/pages' }

    it 'has field with total amount of devices' do
      expect(json['amount']).to eq(110)
    end

    it 'has page number' do
      expect(json['page']).to eq(1)
    end

    it 'provides overall amount of pages' do
      expect(json['pages']).to eq(3)
    end

    it 'provides a list of devices' do
      expect(json['devices'].size).to eq(50)
    end

    it 'shows only available devices' do
      delete "/devices/#{device_id}"
      get '/devices/pages'
      expect(json['amount']).to eq(109)
    end
  end

  # Test page request GET /device/pages/:id - provides a list of devices which fit to the page
  describe 'GET /devices/pages/:id' do
    it 'provide a list of device on the second page' do
      get '/devices/pages/2'
      expect(json['devices'].size).to eq(50)
    end

    it 'has 10 devices on the last page' do
      get '/devices/pages/3'
      expect(json['devices'].size).to eq(10)
    end

    it 'has 0 devices on out-of number page' do
      get '/devices/pages/4'
      expect(json['devices'].size).to eq(0)
    end
  end

  # Test page request for trash
  describe 'GET/trash/pages/:id' do
    before {
      delete "/devices/#{device_id}"
      get '/devices/trash/pages/1'
    }

    it 'has one page only' do
      expect(json['pages']).to eq(1)
    end

    it 'has only one device in the list' do
      expect(json['devices'].size).to eq(1)
    end
  end


end