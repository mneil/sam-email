STACK_NAME=aws-sam-getting-started

all: test package deploy get-url

package:
	sam package \
		--output-template packaged.yaml \
		--s3-bucket sam-788653304537-${AWS_REGION}

deploy:
	sam deploy \
		--template-file packaged.yaml \
		--capabilities CAPABILITY_IAM \
		--stack-name $(STACK_NAME)

get-url:
	aws cloudformation describe-stacks \
		--stack-name $(STACK_NAME) \
		--region ${AWS_REGION} \
		--query "Stacks[*].Outputs[].{Key:OutputKey,Value:OutputValue}"
		# --region ${AWS_REGION} --query "Stacks[].Outputs[?OutputKey==`HelloWorldApi`]"

test:
	# sam local start-api
	@echo "NO TESTS IMPLEMENTED"

