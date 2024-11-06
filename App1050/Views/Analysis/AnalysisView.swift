import SwiftUI

struct AnalysisView: View {
    
    @ObservedObject var viewModel = VMC.shared.makeAnalysisViewModel()
    
    var body: some View {
        ZStack {
            Color.c164209255.ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("Analysis")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        todayEmpty
                        HStack(spacing: 10) {
                            rowingTime
                            speed
                        }
                        HStack(spacing: 10) {
                            goalView
                            numberOfClassesView
                        }
                    }
                    .padding(.bottom, 8)
                }
            }
            .padding(.horizontal, 28)
            .padding(.bottom, bottomPadding)
            .ignoresSafeArea(.container, edges: .bottom)
        }
    }
    
    var todayEmpty: some View {
        ZStack {
            Text("Today")
                .font(.system(size: 32, weight: .medium))
                .foregroundColor(.c038108)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            
            HStack(spacing: 19) {
                if viewModel.totalValue() == 0 {
                    ZStack {
                        Circle()
                            .trim(from: 0, to: 0.4)
                            .stroke(Color.c24480110, style: StrokeStyle(lineWidth: 9.6, lineCap: .round))
                            .scaleEffect(x: -1)
                            .rotationEffect(.degrees(70))
                        Circle()
                            .trim(from: 0.43, to: 0.62)
                            .stroke(Color.c255223107, style: StrokeStyle(lineWidth: 9.6, lineCap: .round))
                            .scaleEffect(x: -1)
                            .rotationEffect(.degrees(70))
                        Circle()
                            .trim(from: 0.65, to: 0.97)
                            .stroke(Color.c181222249, style: StrokeStyle(lineWidth: 9.6, lineCap: .round))
                            .scaleEffect(x: -1)
                            .rotationEffect(.degrees(70))
                    }
                    .overlay(
                        VStack(spacing: 8) {
                            Text("Total")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.c038108)
                            Text("\(viewModel.totalValue())")
                                .font(.system(size: 44, weight: .bold))
                                .foregroundColor(.c038108)
                        }
                    )
                } else {
                    ZStack {
                        Circle()
                            .trim(from: 0, to: min(1,viewModel.speedPercent))
                            .stroke(Color.c24480110, style: StrokeStyle(lineWidth: 9.6, lineCap: .round))
                            .scaleEffect(x: -1)
                            .rotationEffect(.degrees(70))
                        Circle()
                            .trim(from: viewModel.speedPercent + 0.03, to: viewModel.speedPercent + 0.03 + viewModel.timePercent)
                            .stroke(Color.c255223107, style: StrokeStyle(lineWidth: 9.6, lineCap: .round))
                            .scaleEffect(x: -1)
                            .rotationEffect(.degrees(70))
                        Circle()
                            .trim(from: viewModel.speedPercent + 0.06 + viewModel.timePercent, to: 0.97)
                            .stroke(Color.c181222249, style: StrokeStyle(lineWidth: 9.6, lineCap: .round))
                            .scaleEffect(x: -1)
                            .rotationEffect(.degrees(70))
                    }
                    .overlay(
                        VStack(spacing: 8) {
                            Text("Total")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.c038108)
                            Text("\(viewModel.totalValue())")
                                .font(.system(size: 44, weight: .bold))
                                .foregroundColor(.c038108)
                        }
                    )
                }
                
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 5) {
                        Circle()
                            .fill(.c255223107)
                            .frame(width: 6.66, height: 6.66)
                        Text("Time")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.c255223107)
                        Text("\(viewModel.timeSpent()) h")
                            .font(.system(size: 10, weight: .bold))
                    }
                    HStack(spacing: 5) {
                        Circle()
                            .fill(.c24480110)
                            .frame(width: 6.66, height: 6.66)
                        Text("Speed")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.c24480110)
                        Text("\(viewModel.speed()) km/h")
                            .font(.system(size: 10, weight: .bold))
                    }
                    HStack(spacing: 5) {
                        Circle()
                            .fill(.c181222249)
                            .frame(width: 6.66, height: 6.66)
                        Text("Distance")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.c181222249)
                        Text("\(viewModel.distance()) km")
                            .font(.system(size: 10, weight: .bold))
                    }
                }
            }
            .padding(EdgeInsets(top: 16, leading: 35, bottom: 16, trailing: 35))
        }
        .padding(EdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 12))
        .frame(maxWidth: .infinity)
        .frame(height: 214)
        .background(LinearGradient(colors: [.white, .aGradient1], startPoint: .top, endPoint: .bottom))
        .clipShape(.rect(cornerRadius: 25))
        .overlay(
            Text("fill in your data and look at the\nanalysis")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.c038108)
                .padding(EdgeInsets(top: 0, leading: 19, bottom: 0, trailing: 19))
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 52)
                .background(Color.white)
                .clipShape(.rect(cornerRadius: 25))
                .opacity(viewModel.notes.isEmpty ? 1 : 0)
            ,alignment: .bottom
        )
    }
    
    var rowingTime: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 7) {
                Text("Rowing time")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.c038108)
                Text(viewModel.timeSpent() <= 0 ? "Fill in the details in\nthe notes" : "Time spent on the water is: \(viewModel.timeSpent()) hours")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.c038108)
            }
            .padding(EdgeInsets(top: 30, leading: 19, bottom: 0, trailing: 0))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            if viewModel.getYesterdayTimeSpent() > 1 {
                Text("\(Int(viewModel.getYesterdayTimeSpent() * 100)) % better than yesterday")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.c038108)
                    .multilineTextAlignment(.center)
            }
            
            Image("rower1")
                .resizable()
                .scaledToFit()
                .frame(height: 54)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .frame(height: 203)
        .background(LinearGradient(colors: [.white, .c164209255], startPoint: .top, endPoint: .bottom))
        .clipShape(.rect(cornerRadius: 25))
    }
    
    var speed: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 7) {
                Text("Speed")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.c038108)
                Text(viewModel.speed() <= 0 ? "Fill in the details in\nthe notes" : "Уou swam at a\nspeed of \(viewModel.speed()) km/h")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.c038108)
            }
            .padding(EdgeInsets(top: 30, leading: 19, bottom: 0, trailing: 0))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            if viewModel.speed() > 0 {
                Text("Keep it up !")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.c038108)
            }
            
            Image("rower2")
                .resizable()
                .scaledToFit()
                .frame(height: 54)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .frame(height: 203)
        .background(LinearGradient(colors: [.white, .c164209255], startPoint: .top, endPoint: .bottom))
        .clipShape(.rect(cornerRadius: 25))
    }
    
    var goalView: some View {
        VStack(spacing: 10) {
            Text(viewModel.progress() < 0.01 ? "Add a note to\ndefine your goal" : "Уou completed the\ngoal \(Int(viewModel.progress())) percent!")
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.c038108)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 20, leading: 17, bottom: 0, trailing: 17))
            
            Circle()
                .stroke(LinearGradient(colors: [.blueGradient1, .blueGradient2], startPoint: .top, endPoint: .bottom), lineWidth: 10)
                .frame(width: 149, height: 149)
                .overlay(
                    VStack(spacing: 13) {
                        Text("target")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(Color.c48173243)
                        Text("\(viewModel.target())")
                            .font(.system(size: 45, weight: .bold))
                            .foregroundColor(Color.c48173243)
                        Text("km")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(Color.c48173243)
                    }
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .frame(height: 221)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 25))
    }
    
    var numberOfClassesView: some View {
        ZStack {
            Text("Number of classes\nin a row")
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.c038108)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 20, leading: 17, bottom: 0, trailing: 17))
                .frame(maxHeight: .infinity, alignment: .top)
            
            ZStack {
                HStack(spacing: 120) {
                    Text("\(viewModel.getClasses() - 1)")
                        .font(.system(size: 96, weight: .bold))
                        .foregroundColor(.c164209255)
                        .opacity(viewModel.getClasses() > 0 ? 1 : 0)
                    
                    Text("\(viewModel.getClasses() + 1)")
                        .font(.system(size: 96, weight: .bold))
                        .foregroundColor(.c164209255)
                }
                .padding(.leading, -17)
                
                Text("\(viewModel.getClasses())")
                    .font(.system(size: 96, weight: .bold))
                    .foregroundColor(.c164209255)
            }
            .clipped()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 221)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 25))
    }
}

#Preview {
    AnalysisView()
}
