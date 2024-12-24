"use client"
import React from 'react';
import { useState } from 'react';

const page = () => {
  const [task, setTask] = useState("")
  const [desc, setDesc] = useState("")
  const [TaskList, setTaskList] = useState([])
  const submitHandler = (e) => {
    e.preventDefault()
    setTaskList([...TaskList, { task, desc }])
    setTask("")
    setDesc("")

  }
  const deleteHandler = (i) => {
    let copy = [...TaskList]
    copy.splice(i, 1)
    setTaskList(copy)

  }
  let render = <h2>No Task is available</h2>
  if (TaskList.length > 0) {
    render = TaskList.map((t, i) => {
      return (<tr key={i}>
        <td className='text-2xl'>{t.task}</td>
        <td className='text-lg'>{t.desc}</td>
        <td><button onClick={() => {
          deleteHandler(i)
        }} className='bg-red-500 p-2 text-md rounded-full text-white '>Delete</button></td>
      </tr>
      )
    })

  }
  return (
    <div>
      <h1 className=' bg-lime-600 text-white p-6 text-4xl text-center'>Suryans Todo List</h1>
      <form>
        <input type="text" className='text-black border-2 border-lime-500 m-3 px-2 py-2' placeholder='Enter Your Task Here' value={task} onChange={(e) => {
          setTask(e.target.value)
        }} />
        <input type="text" className='text-black border-2 border-lime-500 m-3 px-2 py-2' placeholder='Enter Your Description Here' value={desc} onChange={(e) => {
          setDesc(e.target.value)
        }} />
        <button className='bg-blue-200 px-2 py-1 text-2xl mx-3 rounded shadow-xl ' onClick={submitHandler}>Add Task</button>
      </form>
      <hr />
      <div className='p-6 bg-slate-200 mt-3 '>
        <table className='table w-full text-center border-collapse border-black'>
          {render}
        </table>
      </div>
    </div>
  )
}

export default page