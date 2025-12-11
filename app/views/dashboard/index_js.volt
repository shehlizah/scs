<!-- <script src="/assets/libs/chart.js/Chart.bundle.min.js"></script>
<script src="/assets/libs/moment/min/moment.min.js"></script>
<script src="/assets/libs/jquery.scrollto/jquery.scrollTo.min.js"></script> -->

<!-- Chat app -->
<!-- <script src="/assets/js/pages/jquery.chat.js"></script> -->

<!-- Todo app -->
<!-- <script src="/assets/js/pages/jquery.todo.js"></script> -->

<!-- Dashboard init JS -->
<!-- <script src="/assets/js/pages/dashboard-3.init.js"></script> -->

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<script>

$(document).on('change',"#pick_ym", function(){
    console.log($(this).val());
    window.location = '/dashboard/?pick_ym=' + $(this).val();
});

$(document).on('change',"#pick_ymd", function(){
    console.log($(this).val());
    window.location = '/dashboard/?pick_ymd=' + $(this).val();
});

$('.datepicker_dmy').datepicker({
    format: 'yyyy-mm-dd',
    clearBtn: 'true',
    weekStart: '1',
    autoclose: true
});

Highcharts.setOptions({
    lang: {
  	    thousandsSep: '.'
    },
    credits: {
        enabled: false
    }
})

Highcharts.chart('container', {
    chart: {
        type: 'bar'
    },
    title: {
        text: '',
        align: 'left'
    },
    xAxis: {
        // categories: ['SMAN 1 GOWA', 'SMAN 2 GOWA', 'SMAN 3 GOWA', 'SMAN 4 GOWA', 'SMAN 5 GOWA', 'SMAN 6 GOWA'],
        categories: <?php echo json_encode($data->alist_sekolah); ?>,
        title: {
            text: null
        },
        gridLineWidth: 1,
        lineWidth: 0,
        accessibility: {
            description: 'Sekolah'
        }
    },
    yAxis: {
        min: 0,
        title: {
            text: 'Jumlah Siswa'
        }
    },

    tooltip: {
        valueSuffix: ' Siswa'
    },
    plotOptions: {
        column: {
            pointPadding: 0.2,
            borderWidth: 0
        }
    },
    series: [
        {
            name: 'Jumlah Siswa',
            data: <?php echo json_encode($data->alist_total_siswa); ?>
        },
        {
            name: 'Siswa Enroll Wajah',
            data: <?php echo json_encode($data->alist_total_siswa_fr); ?>
        },
        {
            name: 'Absen Datang',
            data: <?php echo json_encode($data->alist_total_siswa_datang); ?>
        },
        {
            name: 'Datang Tepat Waktu',
            data: <?php echo json_encode($data->alist_total_siswa_datang_ontime); ?>
        },
        {
            name: 'Datang Terlambat',
            data: <?php echo json_encode($data->alist_total_siswa_datang_late); ?>
        },
        {
            name: 'Absen Pulang',
            data: <?php echo json_encode($data->alist_total_siswa_pulang); ?>
        },
        {
            name: 'Pulang Tepat Waktu',
            data: <?php echo json_encode($data->alist_total_siswa_pulang_ontime); ?>
        },
        {
            name: 'Pulang Cepat',
            data: <?php echo json_encode($data->alist_total_siswa_pulang_late); ?>
        }
    ]
});

Highcharts.chart('container_ontime_late', {
    chart: {
        type: 'column'
    },
    title: {
        text: '',
        align: 'left'
    },
    xAxis: {
        // categories: ['SMAN 1 GOWA', 'SMAN 2 GOWA', 'SMAN 3 GOWA', 'SMAN 4 GOWA', 'SMAN 5 GOWA', 'SMAN 6 GOWA'],
        categories: <?php echo json_encode($data->alist_days); ?>,
        crosshair: true,
        accessibility: {
            description: 'SMA'
        }
    },
    yAxis: {
        min: 0,
        title: {
            text: 'Jumlah Siswa'
        }
    },
    tooltip: {
        valueSuffix: ' Siswa'
    },
    plotOptions: {
        column: {
            pointPadding: 0.2,
            borderWidth: 0
        }
    },
    series: [
        {
            name: 'Datang Tepat Waktu',
            data: <?php echo json_encode($data->alist_datang_ontime); ?>
        },
        {
            name: 'Datang Terlambat',
            data: <?php echo json_encode($data->alist_pulang_late); ?>
        },
        {
            name: 'Pulang Tepat Waktu',
            data: <?php echo json_encode($data->alist_datang_ontime); ?>
        },
        {
            name: 'Pulang Cepat',
            data: <?php echo json_encode($data->alist_pulang_late); ?>
        }
    ]
});


</script>