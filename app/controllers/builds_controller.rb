class BuildsController < ApplicationController
    skip_before_action	:authenticate_identity!, only: [:index, :show]
    load_and_authorize_resource	:service
    load_and_authorize_resource	:build

    # GET /builds
    # GET /builds.json
    def index
        @builds = @service.builds
    end

    # GET /builds/1
    # GET /builds/1.json
    def show; end

    # POST /builds
    # POST /builds.json
    def create
        @build = Build.new(build_params)

        respond_to do |format|
            if @build.save
                format.html { redirect_to @build, notice: 'Build was successfully created.' }
                format.json { render :show, status: :created, location: @build }
            else
                format.html { render :new }
                format.json { render json: @build.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /builds/1
    # PATCH/PUT /builds/1.json
    def update
        respond_to do |format|
            if @build.update(build_params)
                format.html { redirect_to @build, notice: 'Build was successfully updated.' }
                format.json { render :show, status: :ok, location: @build }
            else
                format.html { render :edit }
                format.json { render json: @build.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /builds/1
    # DELETE /builds/1.json
    def destroy
        @build.destroy
        respond_to do |format|
            format.html { redirect_to builds_url, notice: 'Build was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_build
        @build = Build.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def build_params
        params.require(:build).permit(:id, :service_version, :version, :container_respository_url, :container_tag, :validated_at, :published_at, :permissions, :release_notes)
    end
end