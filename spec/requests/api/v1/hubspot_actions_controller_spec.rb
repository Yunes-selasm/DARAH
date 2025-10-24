require 'rails_helper'

RSpec.describe(Api::V1::HubspotActionsController, type: :request) do
  describe 'POST #create' do
    context 'when invalid access key' do
      before do
        Rails.application.credentials.api_accessor = '10'

        post('/api/v1/hubspot_actions')
      end

      it do
        expect(error_response).to(eq('Not authorized'))
        expect(response).to(have_http_status(:unauthorized))
      end
    end

    context 'when valid access key' do
      let(:params) do
        {
          hubspot_action: {
            action_type: ''
          }
        }
      end

      before do
        Rails.application.credentials.api_accessor = '10'
      end

      context 'when invalid params' do
        context 'when params not passed' do
          before { post('/api/v1/hubspot_actions', headers:) }

          it { expect(error_response).to(eq('Parameter hubspot_action is required')) }
        end

        context 'when invalid action type' do
          context 'when not passed' do
            before { post('/api/v1/hubspot_actions', headers:, params: { hubspot_action: { body: {} } }, as: :json) }

            it { expect(error_response).to(eq('Parameter hubspot_action[action_type] is required')) }
          end

          context 'when not blank' do
            before { post('/api/v1/hubspot_actions', headers:, params: { hubspot_action: { action_type: '' } }, as: :json) }

            it { expect(error_response).to(eq('Parameter hubspot_action[action_type] cannot be blank')) }
          end

          context 'when invalid type' do
            before { post('/api/v1/hubspot_actions', headers:, params: { hubspot_action: { action_type: 'demo' } }) }

            it do
              expect(error_response).to(
                eq(
                  "Parameter hubspot_action[action_type] must be within [\"create_company\", \"update_company\", \"create_contact\", \"update_contact\"]"
                )
              )
            end
          end
        end

        context 'when company' do
          let(:params) do
            {
              hubspot_action: {
                action_type: 'create_company',
                body: {
                  id: '1',
                  email: 'a@a.com',
                  mobile_number: '12121212',
                  full_name: 'Ahmed Salim',
                  organization_name: 'ASB'
                }
              }
            }
          end

          context 'when invalid organization id' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body][:id] = nil
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end
  
              it { expect(error_response).to(eq('Parameter hubspot_action[body][id] is required')) }
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:id] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end
  
              it { expect(error_response).to(eq('Parameter hubspot_action[body][id] cannot be blank')) }
            end
          end

          context 'when invalid organization name' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body][:organization_name] = nil
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end
  
              it { expect(error_response).to(eq('Parameter hubspot_action[body][organization_name] is required')) }
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:organization_name] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end
  
              it { expect(error_response).to(eq('Parameter hubspot_action[body][organization_name] cannot be blank')) }
            end
          end
        end
  
        context 'when contact' do
          let(:params) do
            {
              hubspot_action: {
                action_type: 'create_contact',
                body: {
                  id: '1',
                  email: 'a@a.com',
                  mobile_number: '12121212',
                  full_name: 'Ahmed Salim',
                  gender: 'male',
                  organization_name: 'ASB'
                }
              }
            }
          end

          context 'when invalid contact id' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body][:id] = nil
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end
  
              it { expect(error_response).to(eq('Parameter hubspot_action[body][id] is required')) }
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:id] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end
  
              it { expect(error_response).to(eq('Parameter hubspot_action[body][id] cannot be blank')) }
            end
          end
  
          context 'when invalid email' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body][:email] = nil
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end
  
              it { expect(error_response).to(eq('Invalid email format')) }
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:email] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end
  
              it { expect(error_response).to(eq('Invalid email format')) }
            end
  
            context 'when invalid format' do
              before do
                params[:hubspot_action][:body][:email] = 'wwe@sds'
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end
  
              it { expect(error_response).to(eq('Invalid email format')) }
            end
          end
  
          context 'when invalid mobile' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body][:mobile_number] = nil
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end
  
              it { expect(error_response).to(eq('Parameter hubspot_action[body][mobile_number] is required')) }
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:mobile_number] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end
  
              it { expect(error_response).to(eq('Parameter hubspot_action[body][mobile_number] cannot be blank')) }
            end
          end
  
          context 'when invalid full_name' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body][:full_name] = nil
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end
  
              it { expect(error_response).to(eq('Parameter hubspot_action[body][full_name] is required')) }
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:full_name] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end
  
              it { expect(error_response).to(eq('Parameter hubspot_action[body][full_name] cannot be blank')) }
            end
          end
        end

        # Services specs

        context 'when service type is publish_book' do
          let(:params) do
            {
              hubspot_action: {
                action_type: 'create_service',
                body: {
                  service_type: 'publish_book',
                  author_name: 'Dr. John Doe',
                  author_academic_degree: 'PhD',
                  book_title: 'The History of Science',
                  book_language: 'English',
                  number_of_volumes: 2,
                  number_of_pages: 300,
                  summary: 'A comprehensive look into the evolution of scientific thought.'
                }
              }
            }
          end

          context 'when invalid author_name' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:author_name)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][author_name] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:author_name] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][author_name] cannot be blank'))
              end
            end
          end

          context 'when invalid author_academic_degree' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:author_academic_degree)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][author_academic_degree] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:author_academic_degree] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][author_academic_degree] cannot be blank'))
              end
            end
          end

          context 'when invalid book_title' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:book_title)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][book_title] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:book_title] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][book_title] cannot be blank'))
              end
            end
          end

          context 'when invalid book_language' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:book_language)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][book_language] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:book_language] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][book_language] cannot be blank'))
              end
            end
          end

          context 'when invalid number_of_volumes' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:number_of_volumes)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][number_of_volumes] is required"))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:number_of_volumes] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("'' is not a valid Integer"))
              end
            end
          end

          context 'when invalid number_of_pages' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:number_of_pages)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][number_of_pages] is required"))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:number_of_pages] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("'' is not a valid Integer"))
              end
            end
          end

          context 'when invalid summary' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:summary)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][summary] is required"))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:summary] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][summary] cannot be blank"))
              end
            end
          end
        end
        
        context 'when service type is publish_scientific_journal' do
          let(:params) do
            {
              hubspot_action: {
                action_type: 'create_service',
                body: {
                  service_type: 'publish_scientific_journal',
                  journal_name: 'Journal of Advanced Studies',
                  researcher_name: 'Dr. John Doe',
                  academic_title: 'PhD',
                  research_title: 'A Study on Quantum Physics',
                  language_of_the_scientific_article: 'English',
                  number_of_pages: 15,
                  abstract_of_the_scientific_article: 'This is a detailed abstract of the scientific article.'
                }
              }
            }
          end

          context 'when invalid journal_name' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:journal_name)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][journal_name] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:journal_name] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][journal_name] cannot be blank'))
              end
            end
          end

          context 'when invalid researcher_name' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:researcher_name)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][researcher_name] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:researcher_name] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][researcher_name] cannot be blank'))
              end
            end
          end

          context 'when invalid academic_title' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:academic_title)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][academic_title] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:academic_title] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][academic_title] cannot be blank'))
              end
            end
          end

          context 'when invalid research_title' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:research_title)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][research_title] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:research_title] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][research_title] cannot be blank'))
              end
            end
          end

          context 'when invalid language_of_the_scientific_article' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:language_of_the_scientific_article)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][language_of_the_scientific_article] is required"))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:language_of_the_scientific_article] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][language_of_the_scientific_article] cannot be blank'))
              end
            end
          end

          context 'when invalid number_of_pages' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:number_of_pages)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][number_of_pages] is required"))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:number_of_pages] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("'' is not a valid Integer"))
              end
            end
          end

          context 'when invalid abstract_of_the_scientific_article' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:abstract_of_the_scientific_article)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][abstract_of_the_scientific_article] is required"))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:abstract_of_the_scientific_article] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][abstract_of_the_scientific_article] cannot be blank"))
              end
            end
          end
        end

        context 'when service type is recording_oral_histories' do
          let(:params) do
            {
              hubspot_action: {
                action_type: 'create_service',
                body: {
                  service_type: 'recording_oral_histories',
                  narrator_name: 'John Doe',
                  age: 45,
                  mobile_number: '1234567890',
                  email: 'johndoe@example.com',
                  region: 'North',
                  city: 'Sample City',
                  national_address: '123 Main St, Sample City',
                  residence_location: '1234 Residential Area',
                  coordinator_s_mobile_number: '0987654321',
                  justifications_for_service_request: 'To preserve oral histories.',
                  topics: 'History, Culture',
                  number_of_people: 10,
                  recording_and_use_consent: true
                }
              }
            }
          end

          context 'when invalid narrator_name' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:narrator_name)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][narrator_name] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:narrator_name] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][narrator_name] cannot be blank'))
              end
            end
          end

          context 'when invalid age' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:age)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][age] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:age] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("'' is not a valid Integer"))
              end
            end
          end

          context 'when invalid mobile_number' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:mobile_number)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][mobile_number] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:mobile_number] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][mobile_number] cannot be blank'))
              end
            end
          end

          context 'when invalid email' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:email)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Invalid email format'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:email] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Invalid email format'))
              end
            end

            context 'when invalid value' do
              before do
                params[:hubspot_action][:body][:email] = 'demo'
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Invalid email format'))
              end
            end
          end

          context 'when invalid region' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:region)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][region] is required"))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:region] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][region] cannot be blank'))
              end
            end
          end

          context 'when invalid city' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:city)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][city] is required"))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:city] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][city] cannot be blank'))
              end
            end
          end

          context 'when invalid national_address' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:national_address)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][national_address] is required"))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:national_address] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][national_address] cannot be blank"))
              end
            end
          end

          context 'when invalid residence_location' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:residence_location)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][residence_location] is required"))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:residence_location] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][residence_location] cannot be blank"))
              end
            end
          end

          context 'when invalid coordinator_s_mobile_number' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:coordinator_s_mobile_number)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][coordinator_s_mobile_number] is required"))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:coordinator_s_mobile_number] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][coordinator_s_mobile_number] cannot be blank"))
              end
            end
          end

          context 'when invalid justifications_for_service_request' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:justifications_for_service_request)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][justifications_for_service_request] is required"))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:justifications_for_service_request] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][justifications_for_service_request] cannot be blank"))
              end
            end
          end

          context 'when invalid topics' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:topics)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][topics] is required"))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:topics] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][topics] cannot be blank"))
              end
            end
          end

          context 'when invalid number_of_people' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:number_of_people)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][number_of_people] is required"))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:number_of_people] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("'' is not a valid Integer"))
              end
            end
          end

          context 'when invalid recording_and_use_consent' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:recording_and_use_consent)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][recording_and_use_consent] is required"))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:recording_and_use_consent] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("'' is not a valid boolean"))
              end
            end
          end
        end
      
        context 'when service type is archive_digitization' do
          let(:params) do
            {
              hubspot_action: {
                action_type: 'create_service',
                body: {
                  service_type: 'archive_digitization',
                  applicant: 'John Smith',
                  type_of_materials: 'Documents',
                  total_quantity_of_archives: '500',
                  condition_of_materials: 'Good',
                  brief_description_of_archives: 'Historical records from the 20th century.',
                  client_requirements: 'Digitization in PDF format.'
                }
              }
            }
          end

          context 'when invalid applicant' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:applicant)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][applicant] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:applicant] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][applicant] cannot be blank'))
              end
            end
          end

          context 'when invalid type_of_materials' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:type_of_materials)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][type_of_materials] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:type_of_materials] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][type_of_materials] cannot be blank'))
              end
            end
          end

          context 'when invalid total_quantity_of_archives' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:total_quantity_of_archives)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][total_quantity_of_archives] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:total_quantity_of_archives] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][total_quantity_of_archives] cannot be blank'))
              end
            end
          end

          context 'when invalid condition_of_materials' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:condition_of_materials)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][condition_of_materials] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:condition_of_materials] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][condition_of_materials] cannot be blank'))
              end
            end
          end

          context 'when invalid brief_description_of_archives' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:brief_description_of_archives)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][brief_description_of_archives] is required"))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:brief_description_of_archives] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][brief_description_of_archives] cannot be blank'))
              end
            end
          end

          context 'when invalid client_requirements' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:client_requirements)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][client_requirements] is required"))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:client_requirements] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][client_requirements] cannot be blank'))
              end
            end
          end
        end

        context 'when service type is deposit_historical_materials' do
          let(:params) do
            {
              hubspot_action: {
                action_type: 'create_service',
                body: {
                  service_type: 'deposit_historical_materials',
                  supply_method: 'Donation',
                  material_type: 'Photographs',
                  material_ownership: 'Owned',
                  brief_description: 'Historical photos from the 19th century.'
                }
              }
            }
          end

          context 'when invalid supply_method' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:supply_method)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][supply_method] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:supply_method] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][supply_method] cannot be blank'))
              end
            end
          end

          context 'when invalid material_type' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:material_type)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][material_type] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:material_type] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][material_type] cannot be blank'))
              end
            end
          end

          context 'when invalid material_ownership' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:material_ownership)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][material_ownership] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:material_ownership] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][material_ownership] cannot be blank'))
              end
            end
          end

          context 'when invalid brief_description' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:brief_description)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][brief_description] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:brief_description] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][brief_description] cannot be blank'))
              end
            end
          end
        end
        
        context 'when service type is lists_of_sources_or_references' do
          let(:params) do
            {
              hubspot_action: {
                action_type: 'create_service',
                body: {
                  service_type: 'lists_of_sources_or_references',
                  purpose_of_the_request: 'Academic Research',
                  request_details: 'Looking for sources on Islamic architecture.',
                  subject_of_the_request: 'Islamic Art',
                  subject_headings: 'Architecture, Calligraphy'
                }
              }
            }
          end

          context 'when invalid purpose_of_the_request' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:purpose_of_the_request)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][purpose_of_the_request] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:purpose_of_the_request] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][purpose_of_the_request] cannot be blank'))
              end
            end
          end

          context 'when invalid request_details' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:request_details)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][request_details] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:request_details] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][request_details] cannot be blank'))
              end
            end
          end

          context 'when invalid subject_of_the_request' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:subject_of_the_request)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][subject_of_the_request] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:subject_of_the_request] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][subject_of_the_request] cannot be blank'))
              end
            end
          end

          context 'when invalid subject_headings' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:subject_headings)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][subject_headings] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:subject_headings] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][subject_headings] cannot be blank'))
              end
            end
          end
        end

        context 'when service type is consulting_services' do
          let(:params) do
            {
              hubspot_action: {
                action_type: 'create_service',
                body: {
                  service_type: 'consulting_services',
                  name_of_the_entity: 'Cultural Heritage Org',
                  purpose_of_the_request: 'Request for archive consultation',
                  request_details: 'Need support in digitization strategy'
                }
              }
            }
          end

          context 'when invalid name_of_the_entity' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:name_of_the_entity)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][name_of_the_entity] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:name_of_the_entity] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][name_of_the_entity] cannot be blank'))
              end
            end
          end

          context 'when invalid purpose_of_the_request' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:purpose_of_the_request)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][purpose_of_the_request] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:purpose_of_the_request] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][purpose_of_the_request] cannot be blank'))
              end
            end
          end

          context 'when invalid request_details' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:request_details)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][request_details] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:request_details] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][request_details] cannot be blank'))
              end
            end
          end
        end

        context 'when service type is general_inquiry' do
          let(:params) do
            {
              hubspot_action: {
                action_type: 'create_service',
                body: {
                  service_type: 'general_inquiry',
                  purpose_of_the_request: 'Ask about archive access',
                  request_details: 'Need info about visiting hours'
                }
              }
            }
          end

          context 'when invalid purpose_of_the_request' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:purpose_of_the_request)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][purpose_of_the_request] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:purpose_of_the_request] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][purpose_of_the_request] cannot be blank'))
              end
            end
          end

          context 'when invalid request_details' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:request_details)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][request_details] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:request_details] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][request_details] cannot be blank'))
              end
            end
          end
        end


        context 'when service type is preserving_historical_materials' do
          let(:params) do
            {
              hubspot_action: {
                action_type: 'create_service',
                body: {
                  service_type: 'preserving_historical_materials',
                  material_type: 'Document',
                  service_required: 'Restoration',
                  form: 'Hard copy',
                  genre: 'Historical',
                  material: 'Paper',
                  summary: 'Old land deeds from 1800s.'
                }
              }
            }
          end

          context 'when invalid material_type' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:material_type)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][material_type] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:material_type] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][material_type] cannot be blank'))
              end
            end
          end

          context 'when invalid service_required' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:service_required)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][service_required] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:service_required] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][service_required] cannot be blank'))
              end
            end
          end

          context 'when invalid form' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:form)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][form] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:form] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][form] cannot be blank'))
              end
            end
          end

          context 'when invalid genre' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:genre)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][genre] is required'))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:genre] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][genre] cannot be blank'))
              end
            end
          end

          context 'when invalid material' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:material)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][material] is required"))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:material] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][material] cannot be blank'))
              end
            end
          end

          context 'when invalid summary' do
            context 'when not passed' do
              before do
                params[:hubspot_action][:body].delete(:summary)
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq("Parameter hubspot_action[body][summary] is required"))
              end
            end
  
            context 'when blank' do
              before do
                params[:hubspot_action][:body][:summary] = ''
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              end

              it do
                expect(error_response).to(eq('Parameter hubspot_action[body][summary] cannot be blank'))
              end
            end
          end
        end

        # Implement
        context 'when service type is access_historical_materials' do
          let(:base_params) do
            {
              hubspot_action: {
                action_type: 'access_historical_materials',
                body: {
                  material_type: 'Book',
                  beneficiary: 'Researcher',
                  record_number: '12345',
                  document_title: 'History of Arabia',
                  document_date: '2023-01-01',
                  classification_number: '001.23',
                  title: 'Rare Manuscripts',
                  manuscript_number: 'M-456',
                  manuscript_title: 'Old Manuscript',
                  author: 'John Doe',
                  copier: 'Jane Doe',
                  collections: 'Private Collection',
                  page_detail: 'p.23-24',
                  book_title: 'Ancient Times',
                  author_name: 'Historian Name',
                  date_of_publication: '2020-12-01',
                  journal_name: 'Journal of History',
                  article_title: 'Arab Heritage',
                  article_author: 'Scholar',
                  issue: '12',
                  year: '2020',
                  issue_date: '2020-12-01',
                  guest_name: 'Guest Speaker',
                  subject: 'Cultural History'
                }
              }
            }
          end
      
          let(:params) { base_params.deep_dup }
      
          # Helper to test required and blank validations
          def expect_required_error(field)
            post('/api/v1/hubspot_actions', headers:, params:, as: :json)
            expect(error_response).to eq("Parameter hubspot_action[body][#{field}] is required")
          end
      
          def expect_blank_error(field)
            post('/api/v1/hubspot_actions', headers:, params:, as: :json)
            expect(error_response).to eq("Parameter hubspot_action[body][#{field}] cannot be blank")
          end
      
          # Required and non-blank fields
          %i[
            material_type beneficiary record_number document_title document_date
            classification_number title manuscript_title author
            book_title author_name date_of_publication journal_name
            article_title article_author issue year issue_date
          ].each do |field|
            context "when #{field} is missing" do
              before { params[:hubspot_action][:body].delete(field) }
              it "returns a required error for #{field}" do
                expect_required_error(field)
              end
            end
      
            context "when #{field} is blank" do
              before { params[:hubspot_action][:body][field] = '' }
              it "returns a blank error for #{field}" do
                expect_blank_error(field)
              end
            end
          end
        end
      end

      context 'when company' do
        context 'when create' do
          let(:params) do
            {
              hubspot_action: [
                {
                  action_type: 'create_company',
                  body: {
                    id: '11',
                    email: 't@t.com',
                    mobile_number: '123123123123',
                    organization_name: 'Spec Co'
                  }
                }
              ]
            }
          end

          it do
            post('/api/v1/hubspot_actions', headers:, params:, as: :json)

            action = HubspotAction.last

            expect(response).to(have_http_status(:ok))
            expect(data_response[0]['id']).to(eq(action.id))
            expect(action).to(be_success)
            expect(action.synced_at).to(be_present)
            expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
            expect(action.metadata['hubspot_record']).to(be_present)
            expect(action.metadata['hubspot_record']['properties']).to(be_present)
          end
        end

        context 'when update' do
          let(:params) do
            {
              hubspot_action: [
                {
                  action_type: 'update_company',
                  body: {
                    id: '11',
                    email: 't@t.net',
                    mobile_number: '000000000001',
                    organization_name: 'Spec Co 10001'
                  }
                }
              ]
            }
          end

          it do
            post('/api/v1/hubspot_actions', headers:, params:, as: :json)

            action = HubspotAction.last

            expect(response).to(have_http_status(:ok))
            expect(data_response[0]['id']).to(eq(action.id))
            expect(action).to(be_success)
            expect(action.synced_at).to(be_present)
            expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
            expect(action.metadata['hubspot_record']).to(be_present)
            expect(action.metadata['hubspot_record']['properties']).to(be_present)
          end
        end
      end

      context 'when contact' do
        context 'when create' do
          let(:params) do
            {
              hubspot_action: [
                {
                  action_type: 'create_contact',
                  body: {
                    id: '11',
                    email: 't@t.com',
                    mobile_number: '123123123123',
                    full_name: 'Spec User',
                    gender: 'Male'
                  }
                }
              ]
            }
          end

          it do
            post('/api/v1/hubspot_actions', headers:, params:, as: :json)

            action = HubspotAction.last

            expect(response).to(have_http_status(:ok))
            expect(data_response[0]['id']).to(eq(action.id))
            expect(action).to(be_success)
            expect(action.synced_at).to(be_present)
            expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
            expect(action.metadata['hubspot_record']).to(be_present)
            expect(action.metadata['hubspot_record']['properties']).to(be_present)
          end
        end

        context 'when update' do
          let(:params) do
            {
              hubspot_action: [
                {
                  action_type: 'update_contact',
                  body: {
                    id: '11',
                    email: 'w@w.net',
                    mobile_number: '22222222',
                    full_name: 'Spec User 22222',
                    gender: 'Female'
                  }
                }
              ]
            }
          end

          it do
            post('/api/v1/hubspot_actions', headers:, params:, as: :json)

            action = HubspotAction.last

            expect(response).to(have_http_status(:ok))
            expect(data_response[0]['id']).to(eq(action.id))
            expect(action).to(be_success)
            expect(action.synced_at).to(be_present)
            expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
            expect(action.metadata['hubspot_record']).to(be_present)
            expect(action.metadata['hubspot_record']['properties']).to(be_present)
          end
        end
      end

      context 'when create service' do
        context 'when publish_book' do
          context 'when contact' do
            context 'when not exisits in hubspot' do
              let(:params) do
                {
                  hubspot_action: [
                     {
                      action_type: 'create_service',
                      body: {
                        service_type: 'publish_book',
                        author_name: 'author_name',
                        author_academic_degree: 'author_academic_degree',
                        book_title: 'book_title',
                        book_language: 'Arabic',
                        number_of_volumes: '111',
                        number_of_pages: '222',
                        summary: 'summary',
                        copy_of_the_book: 'http://example.com/book.pdf',
                        account: {
                          account_type: 'contact',
                          id: '45',
                          full_name: 'firstname',
                          email: 'demo@gmail.com',
                          gender: 'Male',
                          mobile_number: '23123123'
                        }
                      }
                    }
                  ]
                }
              end

              it do
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
                action = HubspotAction.last

                expect(response).to(have_http_status(:ok))
                expect(action).to(be_success)
                expect(data_response[0]['id']).to(eq(action.id))
                expect(action.synced_at).to(be_present)
                expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
                expect(action.metadata['hubspot_record']).to(be_present)
                expect(action.metadata['hubspot_record']['properties']).to(be_present)
              end
            end

            context 'when exists in the hubspot' do
              let(:params) do
                {
                  hubspot_action: [
                     {
                      action_type: 'create_service',
                      body: {
                        service_type: 'publish_book',
                        author_name: 'author_name2',
                        author_academic_degree: 'author_academic_degree',
                        book_title: 'book_title',
                        book_language: 'Arabic',
                        number_of_volumes: '111',
                        number_of_pages: '222',
                        summary: 'summary',
                        copy_of_the_book: 'http://example.com/book.pdf',
                        account: {
                          account_type: 'contact',
                          id: '45',
                          full_name: 'firstname',
                          email: 'demo@gmail.com',
                          gender: 'Male',
                          mobile_number: '23123123'
                        }
                      }
                    }
                  ]
                }
              end

              it do
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
                action = HubspotAction.last

                expect(response).to(have_http_status(:ok))
                expect(action).to(be_success)
                expect(data_response[0]['id']).to(eq(action.id))
                expect(action.synced_at).to(be_present)
                expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
                expect(action.metadata['hubspot_record']).to(be_present)
                expect(action.metadata['hubspot_record']['properties']).to(be_present)
              end
            end
          end

          context 'when company' do
            context 'when not exisits in hubspot' do
              let(:params) do
                {
                  hubspot_action: [
                     {
                      action_type: 'create_service',
                      body: {
                        service_type: 'publish_book',
                        author_name: 'author_name',
                        author_academic_degree: 'author_academic_degree',
                        book_title: 'book_title',
                        book_language: 'Arabic',
                        number_of_volumes: '111',
                        number_of_pages: '222',
                        summary: 'summary',
                        copy_of_the_book: 'http://example.com/book.pdf',
                        account: {
                          account_type: 'company',
                          id: '44',
                          mobile_number: '23123123',
                          email: 'demo@gmail.com',
                          organization_name: 'Spec Organization'
                        }
                      }
                    }
                  ]
                }
              end

              it do
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
                action = HubspotAction.last

                expect(response).to(have_http_status(:ok))
                expect(action).to(be_success)
                expect(data_response[0]['id']).to(eq(action.id))
                expect(action.synced_at).to(be_present)
                expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
                expect(action.metadata['hubspot_record']).to(be_present)
                expect(action.metadata['hubspot_record']['properties']).to(be_present)
              end
            end

            context 'when exists in the hubspot' do
              let(:params) do
                {
                  hubspot_action: [
                     {
                      action_type: 'create_service',
                      body: {
                        service_type: 'publish_book',
                        author_name: 'author_name2',
                        author_academic_degree: 'author_academic_degree',
                        book_title: 'book_title',
                        book_language: 'Arabic',
                        number_of_volumes: '111',
                        number_of_pages: '222',
                        summary: 'summary',
                        copy_of_the_book: 'http://example.com/book.pdf',
                        account: {
                          account_type: 'company',
                          id: '44',
                          mobile_number: '23123123',
                          email: 'demo@gmail.com',
                          organization_name: 'Spec Organization'
                        }
                      }
                    }
                  ]
                }
              end

              it do
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
                action = HubspotAction.last

                expect(response).to(have_http_status(:ok))
                expect(action).to(be_success)
                expect(data_response[0]['id']).to(eq(action.id))
                expect(action.synced_at).to(be_present)
                expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
                expect(action.metadata['hubspot_record']).to(be_present)
                expect(action.metadata['hubspot_record']['properties']).to(be_present)
              end
            end
          end
        end

        context 'when publish_scientific_journal' do
          context 'when company' do
            context 'when not exisits in hubspot' do
              let(:params) do
                {
                  hubspot_action: [
                    {
                      action_type: :create_service,
                      body: {
                        service_type: :publish_scientific_journal,
                        journal_name: 'Al-Dara Arabic Language Journal',
                        researcher_name: 'researcher_name',
                        academic_title: 'academic_title',
                        research_title: 'research_title',
                        language_of_the_scientific_article: 'Arabic',
                        number_of_pages: 10,
                        abstract_of_the_scientific_article: 'abstract_of_the_scientific_article',
                        scientific_article: 'https://www.your_file.com',
                        supporting_documents: 'https://www.your_file.com',
                        research_translation: 'https://www.your_file.com',
                        cv: 'https://www.your_file.com',
                        account: {
                          account_type: 'contact',
                          id: '60',
                          full_name: 'firstname',
                          email: 'demo@gmail.com',
                          gender: 'Male',
                          mobile_number: '23123123'
                        }
                      }
                    }
                  ]
                }
              end

              it do
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
                action = HubspotAction.last

                expect(response).to(have_http_status(:ok))
                expect(action).to(be_success)
                expect(data_response[0]['id']).to(eq(action.id))
                expect(action.synced_at).to(be_present)
                expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
                expect(action.metadata['hubspot_record']).to(be_present)
                expect(action.metadata['hubspot_record']['properties']).to(be_present)
              end
            end

            context 'when exists in the hubspot' do
              let(:params) do
                {
                  hubspot_action: [
                    {
                      action_type: :create_service,
                      body: {
                        service_type: :publish_scientific_journal,
                        journal_name: 'Al-Dara Arabic Language Journal',
                        researcher_name: 'researcher_name',
                        academic_title: 'academic_title',
                        research_title: 'research_title',
                        language_of_the_scientific_article: 'Arabic',
                        number_of_pages: 10,
                        abstract_of_the_scientific_article: 'abstract_of_the_scientific_article',
                        scientific_article: 'https://www.your_file.com',
                        supporting_documents: 'https://www.your_file.com',
                        research_translation: 'https://www.your_file.com',
                        cv: 'https://www.your_file.com',
                        account: {
                          account_type: 'contact',
                          id: '60',
                          full_name: 'firstname',
                          email: 'demo@gmail.com',
                          gender: 'Male',
                          mobile_number: '23123123'
                        }
                      }
                    }
                  ]
                }
              end

              it do
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
                action = HubspotAction.last

                expect(response).to(have_http_status(:ok))
                expect(action).to(be_success)
                expect(data_response[0]['id']).to(eq(action.id))
                expect(action.synced_at).to(be_present)
                expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
                expect(action.metadata['hubspot_record']).to(be_present)
                expect(action.metadata['hubspot_record']['properties']).to(be_present)
              end
            end
          end

          context 'when contact' do
            context 'when not exisits in hubspot' do
              let(:params) do
                {
                  hubspot_action: [
                    {
                      action_type: :create_service,
                      body: {
                        service_type: :publish_scientific_journal,
                        journal_name: 'Al-Dara Arabic Language Journal',
                        researcher_name: 'researcher_name',
                        academic_title: 'academic_title',
                        research_title: 'research_title',
                        language_of_the_scientific_article: 'Arabic',
                        number_of_pages: 10,
                        abstract_of_the_scientific_article: 'abstract_of_the_scientific_article',
                        scientific_article: 'https://www.your_file.com',
                        supporting_documents: 'https://www.your_file.com',
                        research_translation: 'https://www.your_file.com',
                        cv: 'https://www.your_file.com',
                        account: {
                          account_type: 'contact',
                          id: '60',
                          full_name: 'firstname',
                          email: 'demo@gmail.com',
                          gender: 'Male',
                          mobile_number: '23123123'
                        }
                      }
                    }
                  ]
                }
              end

              it do
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
                action = HubspotAction.last

                expect(response).to(have_http_status(:ok))
                expect(action).to(be_success)
                expect(data_response[0]['id']).to(eq(action.id))
                expect(action.synced_at).to(be_present)
                expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
                expect(action.metadata['hubspot_record']).to(be_present)
                expect(action.metadata['hubspot_record']['properties']).to(be_present)
              end
            end

            context 'when exists in the hubspot' do
              let(:params) do
                {
                  hubspot_action: [
                     {
                      action_type: 'create_service',
                      body: {
                        service_type: 'publish_book',
                        author_name: 'author_name2',
                        author_academic_degree: 'author_academic_degree',
                        book_title: 'book_title',
                        book_language: 'Arabic',
                        number_of_volumes: '111',
                        number_of_pages: '222',
                        summary: 'summary',
                        copy_of_the_book: 'http://example.com/book.pdf',
                        account: {
                          account_type: 'contact',
                          id: '60',
                          full_name: 'firstname',
                          email: 'demo@gmail.com',
                          gender: 'Male',
                          mobile_number: '23123123'
                        }
                      }
                    }
                  ]
                }
              end

              it do
                post('/api/v1/hubspot_actions', headers:, params:, as: :json)
                action = HubspotAction.last

                expect(response).to(have_http_status(:ok))
                expect(action).to(be_success)
                expect(data_response[0]['id']).to(eq(action.id))
                expect(action.synced_at).to(be_present)
                expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
                expect(action.metadata['hubspot_record']).to(be_present)
                expect(action.metadata['hubspot_record']['properties']).to(be_present)
              end
            end
          end
        end

        context 'when recording_oral_histories' do
          context 'when company' do
            let(:params) do
              {
                hubspot_action: [
                  {
                    action_type: :create_service,
                    body: {
                      service_type: :recording_oral_histories,
                      narrator_name: 'narrator_name',
                      age: 22,
                      mobile_number: '2341231242',
                      email: 'a@a.com',
                      region: 'region',
                      city: 'city',
                      national_address: 'national_address',
                      residence_location: 'residence_location',
                      coordinator_s_mobile_number: '234234234',
                      topics: 'topics',
                      number_of_people: 22,
                      recording_and_use_consent: true,
                      justifications_for_service_request: 'justifications_for_service_request',
                      file: 'https://www.your_file.com',
                      account: {
                        account_type: :company,
                        id: '100',
                        mobile_number: '23123123',
                        email: 'demo@gmail.com',
                        organization_name: 'organization_name'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last
              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end

          context 'when contact' do
            let(:params) do
              {
                hubspot_action: [
                  {
                    action_type: :create_service,
                    body: {
                      service_type: :recording_oral_histories,
                      narrator_name: 'narrator_name',
                      age: 22,
                      mobile_number: '2341231242',
                      email: 'a@a.com',
                      region: 'region',
                      city: 'city',
                      national_address: 'national_address',
                      residence_location: 'residence_location',
                      coordinator_s_mobile_number: '234234234',
                      topics: 'topics',
                      number_of_people: 22,
                      recording_and_use_consent: true,
                      justifications_for_service_request: 'justifications_for_service_request',
                      file: 'https://www.your_file.com',
                      account: {
                        account_type: 'contact',
                        id: '60',
                        full_name: 'firstname',
                        email: 'demo@gmail.com',
                        gender: 'Male',
                        mobile_number: '23123123'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last
              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end
        end

        context 'when archive_digitization' do
          context 'when company' do
            let(:params) do
              {
                hubspot_action: [
                  {
                    action_type: :create_service,
                    body: {
                      service_type: :archive_digitization,
                      applicant: 'Government agencies',
                      type_of_materials: 'Documents',
                      total_quantity_of_archives: 100,
                      condition_of_materials: 'condition_of_materials',
                      brief_description_of_archives: 'brief_description_of_archives',
                      client_requirements: 'client_requirements',
                      file: '//www.your_file.com',
                      account: {
                        account_type: :company,
                        id: '100',
                        mobile_number: '23123123',
                        email: 'demo@gmail.com',
                        organization_name: 'organization_name'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last
              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end

          context 'when contact' do
            let(:params) do
              {
                hubspot_action: [
                  {
                    action_type: :create_service,
                    body: {
                      service_type: :archive_digitization,
                      applicant: 'Government agencies',
                      type_of_materials: 'Documents',
                      total_quantity_of_archives: 100,
                      condition_of_materials: 'condition_of_materials',
                      brief_description_of_archives: 'brief_description_of_archives',
                      client_requirements: 'client_requirements',
                      file: '//www.your_file.com',
                      account: {
                        account_type: 'contact',
                        id: '60',
                        full_name: 'firstname',
                        email: 'demo@gmail.com',
                        gender: 'Male',
                        mobile_number: '23123123'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last
              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end
        end

        context 'when deposit_historical_materials' do
          context 'when company' do
            let(:params) do
              {
                hubspot_action: [
                  {
                    action_type: 'create_service',
                    body: {
                      service_type: 'deposit_historical_materials',
                      supply_method: 'Dedication',
                      material_type: 'Books',
                      material_ownership: 'Full ownership',
                      brief_description: 'brief_description',
                      file: '//www.your_file.com',
                      account: {
                        account_type: :company,
                        id: '100',
                        mobile_number: '23123123',
                        email: 'demo@gmail.com',
                        organization_name: 'organization_name'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last
              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end

          context 'when contact' do
            let(:params) do
              {
                hubspot_action: [
                  {
                    action_type: 'create_service',
                    body: {
                      service_type: 'deposit_historical_materials',
                      supply_method: 'Dedication',
                      material_type: 'Books',
                      material_ownership: 'Full ownership',
                      brief_description: 'brief_description',
                      file: '//www.your_file.com',
                      account: {
                        account_type: 'contact',
                        id: '60',
                        full_name: 'firstname',
                        email: 'demo@gmail.com',
                        gender: 'Male',
                        mobile_number: '23123123'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last
              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end
        end

        context 'when lists_of_sources_or_references' do
          context 'when company' do
            let(:params) do
              {
                hubspot_action: [
                  {
                    action_type: 'create_service',
                    body: {
                      service_type: 'lists_of_sources_or_references',
                      purpose_of_the_request: 'Preparing a PhD Thesis',
                      request_details: 'Magazines',
                      subject_of_the_request: 'subject_of_the_request',
                      subject_headings: 'subject_he',
                      file: 'https://www.your_file.com',
                      account: {
                        account_type: :company,
                        id: '100',
                        mobile_number: '23123123',
                        email: 'demo@gmail.com',
                        organization_name: 'organization_name'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last
              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end

          context 'when contact' do
            let(:params) do
              {
                hubspot_action: [
                   {
                    action_type: 'create_service',
                    body: {
                      service_type: 'lists_of_sources_or_references',
                      purpose_of_the_request: 'Preparing a PhD Thesis',
                      request_details: 'Magazines',
                      subject_of_the_request: 'subject_of_the_request',
                      subject_headings: 'subject_he',
                      file: 'https://www.your_file.com',
                      account: {
                        account_type: 'contact',
                        id: '60',
                        full_name: 'firstname',
                        email: 'demo@gmail.com',
                        gender: 'Male',
                        mobile_number: '23123123'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last
              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end
        end

        context 'when consulting_services' do
          context 'when company' do
            let(:params) do
              {
                hubspot_action: [
                  {
                    action_type: 'create_service',
                    body: {
                      service_type: 'consulting_services',
                      name_of_the_entity: 'name_of_the_entity',
                       purpose_of_the_request: 'Preparing a PhD Thesis',
                      request_details: 'Documents',
                      file: 'https://www.your_file.com',
                      account: {
                        account_type: :company,
                        id: '100',
                        mobile_number: '23123123',
                        email: 'demo@gmail.com',
                        organization_name: 'organization_name'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last
              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end

          context 'when contact' do
            let(:params) do
              {
                hubspot_action: [
                  {
                    action_type: 'create_service',
                    body: {
                      service_type: 'consulting_services',
                      name_of_the_entity: 'name_of_the_entity',
                      purpose_of_the_request: 'Preparing a PhD Thesis',
                      request_details: 'Documents',
                      file: 'https://www.your_file.com',
                      account: {
                        account_type: 'contact',
                        id: '60',
                        full_name: 'firstname',
                        email: 'demo@gmail.com',
                        gender: 'Male',
                        mobile_number: '23123123'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last
              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end
        end

        context 'when general_inquiry' do
          context 'when company' do
            let(:params) do
              {
                hubspot_action: [
                  {
                    action_type: 'create_service',
                    body: {
                      service_type: 'general_inquiry',
                      purpose_of_the_request: 'Preparing a PhD Thesis',
                      request_details: 'Documents',
                      file: 'https://www.your_file.com',
                      account: {
                        account_type: :company,
                        id: '100',
                        mobile_number: '23123123',
                        email: 'demo@gmail.com',
                        organization_name: 'organization_name'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last
              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end

          context 'when contact' do
            let(:params) do
              {
                hubspot_action: [
                  {
                    action_type: 'create_service',
                    body: {
                      service_type: 'general_inquiry',
                      purpose_of_the_request: 'Preparing a PhD Thesis',
                      request_details: 'Documents',
                      file: 'https://www.your_file.com',
                      account: {
                        account_type: 'contact',
                        id: '60',
                        full_name: 'firstname',
                        email: 'demo@gmail.com',
                        gender: 'Male',
                        mobile_number: '23123123'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last
              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end
        end

        context 'when preserving_historical_materials' do
          context 'when company' do
            let(:params) do
              {
                hubspot_action: [
                  {
                    action_type: 'create_service',
                    body: {
                      service_type: 'preserving_historical_materials',
                      material_type: 'material_type',
                      service_required: "sdsd",
                      form: "sdsd",
                      type: "sdsd",
                      material: "sdsds",
                      summary: 'summary',
                      file: 'https://www.your_file.com',
                      account: {
                        account_type: :company,
                        id: '100',
                        mobile_number: '23123123',
                        email: 'demo@gmail.com',
                        organization_name: 'organization_name'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last
              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end

          context 'when contact' do
            let(:params) do
              {
                hubspot_action: [
                  {
                    action_type: 'create_service',
                    body: {
                      service_type: 'preserving_historical_materials',
                      material_type: 'material_type',
                      service_required: ['service_required1', 'service_required2'],
                      form: ['form1', 'form2'],
                      type: ['type1', 'type2'],
                      material: ['material1', 'material2'],
                      summary: 'summary',
                      file: 'https://www.your_file.com',
                      account: {
                        account_type: 'contact',
                        id: '60',
                        full_name: 'firstname',
                        email: 'demo@gmail.com',
                        gender: 'Male',
                        mobile_number: '23123123'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last
              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end
        end

        context 'when create order' do
          context 'when company' do
            let(:params) do
              {
                hubspot_action: [
                  {
                    action_type: 'create_order',
                    body: {
                      customer_name: 'customer_name',
                      product: 'product',
                      quantity: '11',
                      order_number: 'order_number',
                      order_status: 'In progress',
                      order_date: '2023-10-01',
                      amount: 100,
                      address: 'address',
                      phone: '+966212121212',
                      account: {
                        account_type: :company,
                        id: '100',
                        mobile_number: '23123123',
                        email: 'demo@gmail.com',
                        organization_name: 'organization_name'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last
              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end

          context 'when contact' do
            let(:params) do
              {
                hubspot_action: [
                  {
                    action_type: 'create_order',
                    body: {
                      customer_name: 'customer_name',
                      product: 'product',
                      quantity: '11',
                      order_number: 'order_number',
                      order_status: 'In progress',
                      amount: 100,
                      order_date: '2023-10-01',
                      address: 'address',
                      phone: '+966212121212',
                      account: {
                        account_type: 'contact',
                        id: '60',
                        full_name: 'firstname',
                        email: 'demo@gmail.com',
                        gender: 'Male',
                        mobile_number: '23123123'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last
              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end
        end

        context 'when access_historical_materials' do
          context 'when documents' do
            let(:params) do
              {
                hubspot_action: [
                   {
                    action_type: 'create_service',
                    body: {
                      service_type: 'access_historical_materials',
                      material_type: 'Documents',
                      beneficiary: 'Individual',
                      record_number: 'record_number',
                      document_title: 'document_title',
                      document_date: '2023-10-01',
                      account: {
                        account_type: :company,
                        id: '100',
                        mobile_number: '23123123',
                        email: 'demo@gmail.com',
                        organization_name: 'organization_name'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last

              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end

          context 'when Books' do
            let(:params) do
              {
                hubspot_action: [
                   {
                    action_type: 'create_service',
                    body: {
                      service_type: 'access_historical_materials',
                      material_type: 'Books',
                      beneficiary: 'Individual',
                      book_title: 'book_title',
                      page_detail: 'page_detail',
                      author_name: 'author_name',
                      date_of_publication: '2023-10-01',
                      account: {
                        account_type: :company,
                        id: '100',
                        mobile_number: '23123123',
                        email: 'demo@gmail.com',
                        organization_name: 'organization_name'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              action = HubspotAction.last

              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end

          context 'when Photos' do
            let(:params) do
              {
                hubspot_action: [
                   {
                    action_type: 'create_service',
                    body: {
                      service_type: 'access_historical_materials',
                      material_type: 'Photos',
                      beneficiary: 'Individual',
                      classification_number: '213123123',
                      title: 'title',
                      collections: 'collections',
                      account: {
                        account_type: :company,
                        id: '100',
                        mobile_number: '23123123',
                        email: 'demo@gmail.com',
                        organization_name: 'organization_name'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last

              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end

          context 'when Films' do
            let(:params) do
              {
                hubspot_action: [
                   {
                    action_type: 'create_service',
                    body: {
                      service_type: 'access_historical_materials',
                      material_type: 'Films',
                      beneficiary: 'Individual',
                      classification_number: '213123123',
                      title: 'title',
                      collections: 'collections',
                      account: {
                        account_type: :company,
                        id: '100',
                        mobile_number: '23123123',
                        email: 'demo@gmail.com',
                        organization_name: 'organization_name'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last

              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end

          context 'when Manuscripts' do
            let(:params) do
              {
                hubspot_action: [
                   {
                    action_type: 'create_service',
                    body: {
                      service_type: 'access_historical_materials',
                      material_type: 'Manuscripts',
                      beneficiary: 'Individual',
                      manuscript_number: '213123123',
                      manuscript_title: 'manuscript_title',
                      author: 'author',
                      copier: 'copier',
                      page_detail: 'page_detail',
                      collections: 'collections',
                      account: {
                        account_type: :company,
                        id: '100',
                        mobile_number: '23123123',
                        email: 'demo@gmail.com',
                        organization_name: 'organization_name'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last

              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end

          context 'when Magazines' do
            let(:params) do
              {
                hubspot_action: [
                   {
                    action_type: 'create_service',
                    body: {
                      service_type: 'access_historical_materials',
                      material_type: 'Magazines',
                      beneficiary: 'Individual',
                      journal_name: 'journal_name',
                      article_title: 'article_title',
                      article_author: 'article_author',
                      issue: 'issue',
                      year: 1672531200000,
                      issue_date: '11-11-2023',
                      account: {
                        account_type: :company,
                        id: '100',
                        mobile_number: '23123123',
                        email: 'demo@gmail.com',
                        organization_name: 'organization_name'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last

              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end

          context 'when Oral histories' do
            let(:params) do
              {
                hubspot_action: [
                   {
                    action_type: 'create_service',
                    body: {
                      service_type: 'access_historical_materials',
                      material_type: 'Oral histories',
                      beneficiary: 'Individual',
                      record_number: '112121',
                      subject: 'subject',
                      classification_number: '21323213',
                      guest_name: 'guest_name',
                      account: {
                        account_type: :company,
                        id: '100',
                        mobile_number: '23123123',
                        email: 'demo@gmail.com',
                        organization_name: 'organization_name'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)

              action = HubspotAction.last

              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end

          context 'when Newspapers' do
            let(:params) do
              {
                hubspot_action: [
                   {
                    action_type: 'create_service',
                    body: {
                      service_type: 'access_historical_materials',
                      material_type: 'Newspapers',
                      beneficiary: 'Individual',
                      article_title: 'article_title',
                      year: 1672531200000,
                      issue_date: '11-11-2022',
                      issue: 'issue',
                      journal_name: 'journal_name',
                      account: {
                        account_type: :company,
                        id: '100',
                        mobile_number: '23123123',
                        email: 'demo@gmail.com',
                        organization_name: 'organization_name'
                      }
                    }
                  }
                ]
              }
            end

            it do
              post('/api/v1/hubspot_actions', headers:, params:, as: :json)
              action = HubspotAction.last

              expect(response).to(have_http_status(:ok))
              expect(action).to(be_success)
              expect(data_response[0]['id']).to(eq(action.id))
              expect(action.synced_at).to(be_present)
              expect(action.metadata.keys).to(include('hubspot_record', 'hubspot_object_type'))
              expect(action.metadata['hubspot_record']).to(be_present)
              expect(action.metadata['hubspot_record']['properties']).to(be_present)
            end
          end
        end
      end
    end
  end
end
