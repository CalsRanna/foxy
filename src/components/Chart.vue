<template>
  <canvas id="myChart" width="100%"></canvas>
</template>

<script>
import Chart from "chart.js";

export default {
  data() {
    return {
      ctx: null,
      chart: null,
      timer: 0
    };
  },
  props: {
    labels: {
      type: Array,
      defaultValue: []
    },
    data: {
      type: Array,
      defaultValue: []
    }
  },
  watch: {
    data: function() {
      (this.timer = setTimeout(this.renderChart(), 1000)), clearTimeout(this.timer);
    }
  },
  methods: {
    renderChart() {
      new Chart(this.ctx, {
        type: "polarArea",
        data: {
          labels: this.labels,
          datasets: [
            {
              data: this.data,
              backgroundColor: [
                "rgba(255, 99, 132, 0.8)",
                "rgba(54, 162, 235, 0.8)",
                "rgba(255, 206, 86, 0.8)",
                "rgba(75, 192, 192, 0.8)",
                "rgba(153, 102, 255, 0.8)",
                "rgba(255, 159, 64, 0.8)"
              ],
              borderColor: [
                "rgba(255, 99, 132, 1)",
                "rgba(54, 162, 235, 1)",
                "rgba(255, 206, 86, 1)",
                "rgba(75, 192, 192, 1)",
                "rgba(153, 102, 255, 1)",
                "rgba(255, 159, 64, 1)"
              ],
              borderWidth: 1
            }
          ]
        }
      });
    }
  },
  mounted() {
    this.ctx = document.getElementById("myChart").getContext("2d");
    this.renderChart();
  }
};
</script>
