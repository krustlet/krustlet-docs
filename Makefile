BASE_URL=localhost/krustlet/

build:
	hugo -b ${BASE_URL}

serve:
	hugo server -b ${BASE_URL}
