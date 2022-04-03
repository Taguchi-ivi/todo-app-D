
class ProfilesController < ApplicationController

    before_action :authenticate_user!

    def show
        @profile = current_user.profile
    end

    def edit
        # if current_user.profile.present?
        #     @profile = current_user.profile
        # else
        #     # has_oneの場合は以下になる
        #     @profile = current_user.build_profile
        # end
        @profile = current_user.prepare_profile
    end

    def update
        @profile = current_user.prepare_profile
        @profile.assign_attributes(profile_params)
        if @profile.save
            redirect_to profile_path, notice: '更新しました！'
        else
            flash.now[:error] = '更新できましぇん'
            render :edit
        end
    end

    private

        def profile_params
            params.require(:profile).permit(
                :avatar,
                :nickname,
                :introduction,
                :gender,
                :birthday,
                :subscribed
            )


    end
end