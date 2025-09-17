<script setup lang="ts"></script>

<template>
  <div>
    <h1>Vue + Laravel</h1>
    <button @click="callApi">Call Laravel API</button>
    <div v-if="response">
      <pre>{{ response }}</pre>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const response = ref(null)

const callApi = async () => {
  try {
    const res = await fetch('http://localhost:8080/test')
    const data = await res.json()
    response.value = data
  } catch (error) {
    console.error('Error:', error)
  }
}
</script>
