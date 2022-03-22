module github.com/pulumi/pulumi-hugo

go 1.16

require (
	github.com/pulumi/pulumi-hugo/themes/default v0.0.0-20211008162151-6e65a2068c3b // indirect
	github.com/pulumi/registry/themes/default v0.0.0-20220322220219-ec5c2ed535f3 // indirect
	github.com/pulumi/theme v0.0.0-20220318203150-9c6204b7879c // indirect
)

replace github.com/pulumi/pulumi-hugo/themes/default => ./themes/default
