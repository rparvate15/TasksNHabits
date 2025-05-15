struct ProgressCircle: View {
    @ObservableObject var habit: Habit
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle (
                    lineWidth: 2,
                    lineCap: .round,
                    lineJoin: .round
                )
                )
                .foregroundStyle(.gray)
                .opacity(0.2)
                .fixedSize()
            
            Circle()
                .trim(from: 0, to: CGFloat(habit.currentAmount) / CGFloat(habit.totalAmount))
                .stroke(style: StrokeStyle (
                    lineWidth: 2,
                    lineCap: .round,
                    lineJoin: .round
                )
                )
                .foregroundStyle(.purple)
                .fixedSize()
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.3), value: habit.currentAmount)
        }
    }
}
