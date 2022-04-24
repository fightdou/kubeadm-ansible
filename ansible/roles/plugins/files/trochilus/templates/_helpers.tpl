{{/*
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
   http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/}}

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

{{/* vim: set filetype=mustache: */}}
{{/*
Return the proper image name
{{ include "common.images.image" ( dict "imageRoot" .Values.path.to.the.image "global" $) }}
*/}}
{{- define "common.images.image" -}}
{{- $repositoryName := .imageRoot.repository -}}
{{- $registryName := .global.imageRegistry -}}
{{- $tag := .global.imageTag | toString -}}
{{- if .imageRoot.registry }}
    {{- $registryName = .imageRoot.registry -}}
{{- end }}
{{- if .imageRoot.tag }}
    {{- $tag = .imageRoot.tag | toString -}}
{{- end }}
{{- if $registryName }}
{{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- else -}}
{{- printf "%s:%s" $repositoryName $tag -}}
{{- end -}}
{{- end -}}


{{/*
Return the proper trochilus api image name
*/}}
{{- define "trochilus_api.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.image.trochilus_api "global" .Values.global) -}}
{{- end -}}

{{/*
Return the proper trochilus agent image name
*/}}
{{- define "trochilus_agent.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.image.trochilus_agent "global" .Values.global) -}}
{{- end -}}

{{/*
Return the proper entrypoint image name
*/}}
{{- define "entrypoint.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.image.entrypoint "global" .Values.global) -}}
{{- end -}}

{{/*
Return the proper db_init image name
*/}}
{{- define "db_init.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.image.db_init "global" .Values.global) -}}
{{- end -}}

{{/*
Return the proper db_sync image name
*/}}
{{- define "db_sync.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.image.db_sync "global" .Values.global) -}}
{{- end -}}

{{/*
Return the Database host
*/}}
{{- define "mariadb.databaseHost" -}}
{{- $releaseNamespace := .Release.Namespace }}
{{- $clusterDomain := .Values.clusterDomainSuffix }}
{{- printf "%s.%s.svc.%s" "mariadb" $releaseNamespace $clusterDomain -}}
{{- end -}}
