{{/*
abstract: |
  Joins a list of values into a comma separated string
values: |
  test:
    - foo
    - bar
usage: |
  {{ include "common.utils.joinListWithComma" .Values.test }}
return: |
  foo,bar
*/}}

{{- define "common.utils.joinListWithComma" -}}
{{- $local := dict "first" true -}}
{{- range $k, $v := . -}}{{- if not $local.first -}},{{- end -}}{{- $v -}}{{- $_ := set $local "first" false -}}{{- end -}}
{{- end -}}

{{/*
Renders a value that contains template.
Usage:
{{ include "common.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "common.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}

{{/*
Return the Database host
*/}}
{{- define "mariadb.databaseHost" -}}
{{- $releaseNamespace := .Release.Namespace }}
{{- $clusterDomain := .Values.clusterDomainSuffix }}
{{- printf "%s.%s.svc.%s" "mariadb" $releaseNamespace $clusterDomain -}}
{{- end -}}
