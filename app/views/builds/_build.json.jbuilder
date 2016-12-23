json.extract! build, :id, :service_version, :version, :container_respository_url, :container_tag, :validated_at, :published_at, :permissions, :release_notes, :created_at, :updated_at
json.url service_build_url(build.service, build)
json.screenshots do
	json.array! build.screenshots do |s|
		json.extract! :id
		json.url service_build_screenshot_url(build.service, build, s)
		json.path service_build_screenshot_url(build.service, build, s)
	end
end
