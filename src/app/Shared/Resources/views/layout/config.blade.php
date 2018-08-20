<script type="application/javascript">
    {{ 'window.Config = ' }}{!! json_encode($exposed_config, JSON_FORCE_OBJECT | JSON_UNESCAPED_SLASHES) !!};
</script>
