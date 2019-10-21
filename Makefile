STACK_NAME=aws-sam-getting-started
ACCOUNT_ID=788653304537

all: build test package deploy get-url

build:
	sam build

package:
	sam package \
		--output-template packaged.yaml \
		--s3-bucket sam-$(ACCOUNT_ID)-${AWS_REGION}

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

test:
	# sam local start-api
	@echo "NO TESTS IMPLEMENTED"

